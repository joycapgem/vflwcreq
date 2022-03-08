public With Sharing class TruckTriggerHandler {
    public static void updateStatus(list<A_Truck_Booking__c> recs, string status){
        Set<ID> truckIds = new Set<Id>();
        
        for(A_Truck_Booking__c ob : recs){
            truckIds.add(ob.Truck_Details__c);
        }
        
        list<A_Truck__c> trucks = [select id, Name, Truck_Number__c, Booking_Status__c, Price_Per_Day__c, Owner__c, Owner_email__c, Load_Details__c, Financer_Email__c from A_Truck__c where id in :truckIds];
        
        list<A_Truck__c> updTrucks = new list<A_Truck__c>();
        system.debug('Updating ' + status + ' status.');
        for(A_Truck__c truck : trucks){
            truck.Booking_Status__c = status;
            updTrucks.add(truck);
        }
        update updTrucks;
    }
}