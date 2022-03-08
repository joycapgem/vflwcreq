public class DriverHandler2 {
    public static void getBookings(){
        list<Booking_Status__c> drs = [select id, booking__c, Booking_Status__c, Name, Driver__c from Booking_Status__c limit 5];
        
        system.debug(drs);
    }
}