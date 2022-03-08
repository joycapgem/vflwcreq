@istest
public with sharing class CheckSecretInformationTest {
    @istest
    public static void   CheckSecretInformationTest() {
        case mc = new case();
        mc.Subject = 'Help!!!';
        mc.Description = 'My bodyweight is 180 pounds!!!';
        mc.reason__c = mc.Description;
        insert mc;
    }
}