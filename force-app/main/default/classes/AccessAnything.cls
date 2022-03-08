public without sharing class AccessAnything {
    public static Map<Id, string> getBookings(list<string> ids) {
        list<A_Truck_Booking__c> bName = [select Id, Name from A_Truck_Booking__c where Name=:ids];

        Map<Id, string> items = new Map<Id, String>();

        for(A_Truck_Booking__c ob : bName){
            items.put(ob.Id, ob.Name);
        }

        return items;
    }
}