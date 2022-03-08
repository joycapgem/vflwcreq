@isTest
public class MgrGetTrucksTest {
    @TestSetup
    static void makeData(){
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

        insert trucks;
    }

    @isTest
    static void  getAllTrucksP1() {
        list<A_Truck__c> aTrucks = ManagerHandler.getTrucks();
        system.assertEquals(2, aTrucks.size(), 'Not two!!!');
    }

    @isTest
    static void  getAllTrucksP2() {
        list<A_Truck__c> aTrucks = ManagerHandler.getTrucks();

        for(A_Truck__c tr : aTrucks){
            system.assertEquals('Available', tr.Booking_Status__c, 'Ok');
        }
    }

    @isTest
    static void  getAllTrucksN1() {

        // if booked trucks are returned...
        list<A_Truck__c> aTrucks = ManagerHandler.getTrucks();

        for(A_Truck__c tr : aTrucks){
            system.assertNotEquals('Booking', tr.Booking_Status__c, 'Not "Available"!!!');
        }
    }
}