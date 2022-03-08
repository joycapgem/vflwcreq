@isTest
public class MgrGetBookingsTest {
    @TestSetup
    static void makeData(){
        // trucks 
        list<A_Truck__c> trucks = new list<A_Truck__c>();

        for(Integer i=0; i<2; i++){
            string num = 'AP 100 TE 90' + i;
            A_Truck__c truck = new A_Truck__c(
                Truck_Number__c = num,
                Load_Details__c = 1000,
                Booking_Status__c = 'Available',
                Price_Per_Day__c = 10000,
                Owner_email__c = 'mtestersas1@gmail.com'
            );

            trucks.add(truck);
        }

        // bookings
        list<A_Truck_Booking__c> bkngs = new list<A_Truck_Booking__c>();

        for(Integer i=0; i<2; i++){
            A_Truck_Booking__c ob = new A_Truck_Booking__c(
                Date_of_Booking__c = Date.newInstance(2021, 2, 17),
                Customer_Name__c = 'test ' + (i + 1),
                Load_Details_in_KG__c = 100,
                Number_of_days__c = 2,
                Pickup_Location__c = 'Andhra Pradesh',
                Drop_Location__c = 'Andhra Pradesh',
                Customer_Phone_Number__c = '9989654759',
                Truck_Details__c = trucks.get(i).Id,
                Payment_Type__c = 'One Time'
            );

            bkngs.add(ob);
        }

        insert bkngs;
    }

    @isTest
    public static void MgrGetBookingsTestP1() {

        list<A_Truck_Booking__c> bkngs = [select Id, Name, Customer_Name__c, Number_of_days__c from A_Truck_Booking__c];

        system.assertEquals(2, bkngs.size());

    }

    @isTest
    public static void MgrGetBookingsTestP2() {

        list<A_Truck_Booking__c> bkngs = [select Id, Name, Customer_Name__c, Number_of_days__c from A_Truck_Booking__c];

        for(A_Truck_Booking__c bk : bkngs){
            system.assertEquals(100, bk.Load_Details_in_KG__c);
        }

    }

    @isTest
    public static void MgrGetBookingsTestN1() {

        list<A_Truck_Booking__c> bkngs = [select Id, Name, Customer_Name__c, Number_of_days__c from A_Truck_Booking__c];

        for(A_Truck_Booking__c bk : bkngs){
            system.assertNotEquals(1001, bk.Load_Details_in_KG__c);
        }

    }
}