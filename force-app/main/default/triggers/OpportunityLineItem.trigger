trigger OpportunityLineItem on OpportunityLineItem (after insert,after update,after delete) {
    Set<Id> LineItemIds = new Set<Id>();
    for (OpportunityLineItem oppLineItem : Trigger.new) {
        LineItemIds.add(oppLineItem.OpportunityId);
        System.debug(oppLineItem.OpportunityId);
    }
    List<Opportunity> updateBookCount = [SELECT Id, Name, Account.Name, (SELECT Id FROM OpportunityLineItems) FROM Opportunity WHERE Id IN:LineItemIds];
    Map<Id, Account> accToUpdate = new Map<Id, Account>();
    for (Opportunity updateAcc : updateBookCount) {
        Account acc = new Account();
        acc.Id = updateAcc.AccountId;
        acc.Number_of_Books_Borrowed_till_date__c = updateAcc.OpportunityLineItems.size();
        accToUpdate.put(acc.Id, acc);
    }
     if (!accToUpdate.isEmpty()) {
        update accToUpdate.values();
    }
    List<Opportunity> updateOverDue = [SELECT Id, Name, Account.Name, (SELECT Id FROM OpportunityLineItems Where Status__c=:'Overdue') FROM Opportunity WHERE Id IN:LineItemIds];
    Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
    for (Opportunity updateAcc : updateOverDue) {
        Account acc = new Account();
        acc.Id = updateAcc.AccountId;
        acc.Number_of_overdue_Books__c = updateAcc.OpportunityLineItems.size();
        accountsToUpdate.put(acc.Id, acc);
    }
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate.values();
    }
}