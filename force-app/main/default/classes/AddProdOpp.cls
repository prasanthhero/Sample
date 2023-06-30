public class AddProdOpp {
    
    public static void getProduct(String ProductId, String OppId) {
        System.debug('hello');
        List<OpportunityLineItem> oppProducts = new List<OpportunityLineItem>();
        PricebookEntry priceEntry = [SELECT Id,UnitPrice FROM PricebookEntry WHERE Product2Id = :ProductId LIMIT 1];
        System.debug('oppId: '+OppId);
        System.debug('hgdsf'+ProductId);
        OpportunityLineItem newOppProduct = new OpportunityLineItem(
            OpportunityId = OppId,
            Product2Id = ProductId,
            PricebookEntryId = priceEntry.Id,
            Quantity = 1,
            UnitPrice = priceEntry.UnitPrice
        );
        oppProducts.add(newOppProduct);
        insert oppProducts;
    }
}