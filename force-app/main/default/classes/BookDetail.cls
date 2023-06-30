public class BookDetail {
@AuraEnabled(cacheable=true)
public static List<Product2> getName(String Name) {
        if (String.isBlank(Name)) {
        return [SELECT Id, Name, ProductCode, Description,ImageUrl__c, Unit_Cost__c,Total_Cost__c,Quantity__c
        FROM Product2 
        WHERE ProductCode LIKE 'Book-%'
        ];
        } else {
        String keySearch = '%' + Name + '%';
        return [SELECT Id, Name, ProductCode, Description,ImageUrl__c, (SELECT Id, UnitPrice FROM PricebookEntries)
        FROM Product2 
        WHERE Name LIKE :keySearch AND ProductCode LIKE 'Book-%'
        ];
        }
    }
}