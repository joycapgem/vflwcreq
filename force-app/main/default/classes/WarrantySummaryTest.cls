@istest
public with sharing class WarrantySummaryTest {
    @istest
    public static void WarrantySummaryTest() {
        case c = new case();
        c.product_purchase_date__c = date.today();
        c.product_total_warranty_days__c = 10;
        c.product_has_extended_warranty__c = true;
        c.reason__c = 'silly';
        insert c;
    }
}