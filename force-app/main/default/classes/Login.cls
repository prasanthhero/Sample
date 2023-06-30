public class Login {
@AuraEnabled
    public static Id getLeadConversionData(String leadId) {
        Lead leadRecord = [SELECT Id, Name, Email, Company, Phone, Status FROM Lead WHERE Id = :leadId];
        
        Account newAccount = new Account();
        newAccount.Name = leadRecord.Company;
        insert newAccount;

        Contact newContact = new Contact();
        newContact.LastName = leadRecord.Name;
        newContact.Email = leadRecord.Email;
        newContact.AccountId = newAccount.Id;
        insert newContact;

        Opportunity newOpportunity = new Opportunity();
        newOpportunity.Name = leadRecord.Name;
        newOpportunity.StageName = 'Prospecting';
        newOpportunity.CloseDate = System.today().addMonths(1);
        newOpportunity.AccountId = newAccount.Id;
        insert newOpportunity;

        return newOpportunity.Id;
    }
}