public with sharing class ManagerHandler {
    @AuraEnabled(Cacheable=true)
    public static list<A_Truck__c> getTrucks(){
        list<A_Truck__c> retTrucks = new list<A_Truck__c>();
        try {
            list<A_Truck__c> trks = [select Id, Truck_Image__c, Name, Truck_Number__c, Load_Details__c, Booking_Status__c, Price_Per_Day__c, Owner_email__c, Financer_Email__c from A_Truck__c order by Name DESC];
            
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
    public static list<A_Driver__c> getDrivers(){
        try {
            list<A_Driver__c> drs = [SELECT Driver_Email__c, Driver_Name__c, Id, Lisence__c, Mobile_Number__c, Name, Status__c FROM A_Driver__c order by Name DESC];
            return drs;
        } catch (Exception e) {
            system.debug(e.getMessage());
        }

        return null;
    }

    public static void shareRecordsToDriver(list<A_Truck_Booking__c> bookings){
        list<A_Truck_Booking__share> bookShare = new list<A_Truck_Booking__share>();
        system.debug('Initializing sharing...');
        list<Id> drs = new list<Id>();

        try{
            for(A_Truck_Booking__c b : bookings){
                drs.add(b.Assigned_Driver__c);
            }

            list<A_Driver__c> dr2 = [select Id, Driver_user__c from A_Driver__c where Id in :drs];

            for(A_Truck_Booking__c b : bookings){
                A_Truck_Booking__share ob = new A_Truck_Booking__share();
                // set the id of the record to share
                ob.parentId = b.Id;
                system.debug('sharing ' + b.Name);
                // find the user Id
                Id userId = null;
                for(A_Driver__c dr : dr2){
                    if(dr.Id == b.Assigned_Driver__c){
                        userId = dr.Driver_user__c;
                    }
                }

                // set the user id to which we want to share
                ob.userOrGroupId = userId;
                system.debug('sharing to ' + userId);

                // set share access
                ob.accessLevel = 'Edit';

                bookShare.add(ob);
            }

            list<Database.SaveResult> sr = Database.insert(bookShare, false);
            system.debug('Shared.');

        } catch (Exception e) {
            system.debug(e.getMessage());
        }
    }
}