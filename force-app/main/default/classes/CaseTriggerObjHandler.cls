public class CaseTriggerObjHandler {   
    public static void nonconformanceCreation(List<Case> newCases, Map<Id, Case> oldMap) {
        
        List<SQX_Nonconformance__c> nonconformanceList = new List<SQX_Nonconformance__c>();

        for (Case caseRecord : newCases) {
            if (isProblemCase(caseRecord, oldMap)) {
                if (!nonconformanceExists(caseRecord.Id)) {
                
                    SQX_Nonconformance__c nonconformance = new SQX_Nonconformance__c(
                        Priority__c = caseRecord.Priority,
                        Title__c = caseRecord.Subject,
                        Description__c = caseRecord.Description,
                        QMS_Reference_Number__c = caseRecord.CaseNumber);
                    nonconformanceList.add(nonconformance);
                    caseRecord.SQX_NC_Reference__c = nonconformance.Id;
                }
            }
        }

        if (!nonconformanceList.isEmpty()) {
            insert nonconformanceList;
            update newCases;
        }
    }

    private static Boolean isProblemCase(Case caseRecord, Map<Id, Case> oldMap) {
        return caseRecord.Type == 'Problem' && (oldMap == null || oldMap.get(caseRecord.Id).Type != 'Problem');
    }

    private static Boolean nonconformanceExists(Id caseId) {
        return [SELECT COUNT() FROM SQX_Nonconformance__c WHERE Case__c = :caseId] > 0;
    }
}