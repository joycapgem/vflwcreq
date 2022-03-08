public with sharing class DriverHandler {
    @AuraEnabled(cacheable=true)
    public static list<A_Truck_Booking__c> getBookings() {
        // list<Map<string, string>> res = new list<Map<string, string>>();
        try{
            list<A_Truck_Booking__c> bks = [select Id, Name, Booking_Status__c from A_Truck_Booking__c order by Name DESC];

            return bks;
        }catch(Exception e){
            system.debug(e.getMessage());
        }

        return null;
    }

    public static void updateDriver(list<A_Truck_Booking__c> books, string status){
        Set<ID> drIds = new Set<Id>();

        for(A_Truck_Booking__c ob : books){
            drIds.add(ob.Assigned_Driver__c);
        }

        list<A_Driver__c> drvrs = [select Id, Status__c from A_Driver__c where Id in :drIds];

        list<A_Driver__c> updDrvs = new list<A_Driver__c>();

        try{

            for(A_Driver__c dr : drvrs){
                dr.Status__c = status;
                updDrvs.add(dr);
            }

            update updDrvs;
        }catch(Exception e){
            system.debug(e.getMessage());
        }
    }
}