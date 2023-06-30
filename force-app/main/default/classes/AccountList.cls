public class AccountList {
@AuraEnabled(cacheable=true)
    public static List<Account> getaccRec() {
        return [SELECT Id, Name,PersonEmail,Total_Fine_Paid__c,Number_of_Books_Borrowed_till_date__c,Number_of_overdue_Books__c,Last_book_borrowed__c  FROM Account];
    }
}