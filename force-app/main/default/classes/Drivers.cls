public with sharing class Drivers {
    
    public static void getDrivers(){
        list<A_Driver__c> drivers = [select id, Driver_Name__c, Driver_Email__c, Status__c, Mobile_Number__c from A_Driver__c];
        
        System.debug('Number of trucks: ' + drivers.size());
        
        for(A_Driver__c ob : drivers){
            System.debug('Truck Name : ' + ob.Driver_Name__c);
            System.debug('Truck Number: ' + ob.Mobile_Number__c);
            System.debug('Truck Booking Status : ' + ob.Status__c);
        }
    }
    
    public static void updateDrivers(){
        list<A_Driver__c> drivers = [select id, Driver_Name__c, Driver_Email__c, Status__c, Mobile_Number__c from A_Driver__c];
        
        System.debug('Number of trucks: ' + drivers.size());
        
        for(A_Driver__c ob : drivers){
            if(ob.Status__c.equals('Booked')){
                ob.Status__c = 'Available';
            }
        }
        
        update drivers;
        System.debug('Updated');

    }
    
    

}