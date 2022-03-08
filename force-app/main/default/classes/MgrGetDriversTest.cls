@isTest
public with sharing class MgrGetDriversTest {
    @TestSetup
    static void makeData(){
        list<A_Driver__c> drs = new list<A_Driver__c>();

        for(Integer i=0; i<2; i++){
            A_Driver__c dr = new A_Driver__c(
                Driver_Name__c = 'Hari',
                Driver_Email__c = 'dadriver9@gmail.com',
                Mobile_Number__c = '9989998596',
                Status__c = 'Available',
                Lisence__c = 'HR-0619850034761'
            );

            drs.add(dr);
        }

        insert drs;
    }

    @isTest
    public static void getDriversTest() {
        list<A_Driver__c> drs = [select Id from A_Driver__c];

        system.assertEquals(2, drs.size());

    }
}