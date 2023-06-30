trigger CloudNewsTrigger on Cloud_New__e (after insert) {
    List<Case> cases = new List<Case>();
    Group queue = [SELECT Id FROM Group WHERE Name='Demo' AND Type='Queue'];
    
    for (Cloud_New__e event : Trigger.New) {
        if (event.Urgent__c == true) {
            Case cs = new Case();
            cs.Priority = 'High';
            cs.Subject = 'News team dispatch to ' + event.Location__c;
            cs.OwnerId = queue.Id;
            cases.add(cs);
        }
    }
    
    if (!cases.isEmpty()) {
        insert cases;
    }
}