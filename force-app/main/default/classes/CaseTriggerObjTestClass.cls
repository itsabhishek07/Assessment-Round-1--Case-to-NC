@isTest
public class CaseTriggerObjTestClass {
   static testMethod void testCaseNonconformanceCreation() {
        
        Case testCase = new Case(
            Type = 'Problem',
            Priority = 'High',
            Subject = 'Test Subject',
            Description = 'Test Description');
        insert testCase;
       
        List<SQX_Nonconformance__c> nonconformanceList = [SELECT Id FROM SQX_Nonconformance__c WHERE Case__c = :testCase.Id];
        System.assertEquals(1, nonconformanceList.size(), 'Nonconformance record not created');

        Case updatedCase = [SELECT Id, SQX_NC_Reference__c FROM Case WHERE Id = :testCase.Id];
        System.assertNotEquals(null, updatedCase.SQX_NC_Reference__c, 'SQX NC Reference field not populated');

        testCase.Priority = 'Low';
        update testCase;
       
        List<SQX_Nonconformance__c> updatedNonconformanceList = [SELECT Id FROM SQX_Nonconformance__c WHERE Case__c = :testCase.Id];
        System.assertEquals(1, updatedNonconformanceList.size(), 'Additional Nonconformance record created');
    }
}