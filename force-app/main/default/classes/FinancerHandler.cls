public with sharing class FinancerHandler {
    @AuraEnabled(Cacheable=true)
    public static list<A_Payment__c> getPaymentsList(){
        try {
            list<A_Payment__c> ps = [select id, Name, Booking__r.Name, Payment_Status__c, Payment__c, Total_Price_for_Booking__c from A_Payment__c order by Name DESC];
            
            return ps;


        } catch (Exception e) {
            system.debug(e.getMessage());
        }

        return null;
    }
}