public with sharing class Trucks {
    public static void getTrucks(){
		list<A_Truck__c> trucks = [select id, Name, Truck_Number__c, Booking_Status__c, Price_Per_Day__c, Owner__c, Owner_email__c, Load_Details__c, Financer_Email__c from A_Truck__c];
        
        System.debug('Number of trucks: ' + trucks.size());
        
        for(A_Truck__c ob : trucks){
            System.debug('Truck Name : ' + ob.Name);
            System.debug('Truck Number: ' + ob.Truck_Number__c);
            System.debug('Truck Booking Status : ' + ob.Booking_Status__c);  
            System.debug(ob.Price_Per_Day__c);
            System.debug(ob.Owner__c);
            System.debug(ob.Owner_email__c);
            System.debug(ob.Load_Details__c);
            System.debug(ob.Financer_Email__c);
        }
        
    }
    
    public static void updateTrucks(){
       	list<A_Truck__c> trucks = [select id, Name, Truck_Number__c, Booking_Status__c, Price_Per_Day__c, Owner__c, Owner_email__c, Load_Details__c, Financer_Email__c from A_Truck__c];
		
        //list<A_Truck__c> updTrucks = new list<A_Truck__c>();
        
        for(A_Truck__c ob : trucks){
            if(ob.Booking_Status__c.equals('Booked')){
                ob.Booking_Status__c = 'Available';
            }
        }
        
        update trucks;
        System.debug('Updated');
    }
}