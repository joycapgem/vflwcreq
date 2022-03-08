public with sharing class CustomerHandler {
    @AuraEnabled(Cacheable=true)
    public static list<A_Truck__c> getTrucks(){
        list<A_Truck__c> retTrucks = new list<A_Truck__c>();
        try {
            list<A_Truck__c> trks = [select Id, Truck_Image__c, Name, Truck_Number__c, Load_Details__c, Booking_Status__c, Price_Per_Day__c from A_Truck__c where Booking_Status__c = 'Available' order by Name DESC];

            for(A_Truck__c trk : trks){
                trk.Truck_Image__c = GetImages.getLink(trk.Truck_Image__c);

                retTrucks.add(trk);
            }

            return retTrucks;

        } catch (Exception e) {
            system.debug(e.getMessage());
        }

        return null;
    }

    @AuraEnabled(Cacheable=true)
    public static list<A_Truck_Booking__c> getBookings(){
        try {
            list<A_Truck_Booking__c> bkngs = [select Id, Name, Customer_Name__c, Booking_Status__c, Pickup_Location__c, Drop_Location__c, Payment_Type__c from A_Truck_Booking__c order by Name DESC];
            return bkngs;
        } catch (Exception e) {
            system.debug(e.getMessage());
        }

        return null;
    }

    @AuraEnabled(Cacheable=true)
    public static list<Grievance__c> getGrev(){
        try{
            list<Grievance__c> grev = [select Id, Name, Booking__r.Name, Customer_Name__c, Custom_Status__c, Reason__c from Grievance__c order by Name DESC];
            
            return grev;
        } catch (Exception e) {
            system.debug(e.getMessage());
        }

        return null;
    }
}