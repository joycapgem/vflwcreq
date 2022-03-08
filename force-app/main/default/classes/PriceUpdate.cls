public with sharing class PriceUpdate {
    public static void PriceUpdateOnBookings(list<A_Truck_Booking__c> books) {
        Set<ID> truckIds = new Set<Id>();

        for(A_Truck_Booking__c ob : books){
            truckIds.add(ob.Truck_Details__c);
        }

        list<A_Truck__c> trucks = [select id, Price_Per_Day__c from A_Truck__c where id in :truckIds];
        
        // list<A_Truck_Booking__c> updTrucks = new list<A_Truck_Booking__c>();
        
        for(A_Truck_Booking__c bkng : books){
            decimal ppd = null;
            decimal tp = null;
            decimal n = null;

            for(A_Truck__c tk : trucks){
                if(tk.Id == bkng.Truck_Details__c){
                    ppd = tk.Price_Per_Day__c;
                    n = bkng.Number_of_days__c;
                    tp = ppd * n;
                }
            }

            bkng.Total_Price__c = tp;

            // updTrucks.add(bkng);
        }

        // insert updTrucks;
    }
}