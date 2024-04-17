trigger CaseTriggerObj on Case (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            CaseTriggerObjHandler.nonconformanceCreation(Trigger.new, Trigger.oldMap);
        }
    }
}