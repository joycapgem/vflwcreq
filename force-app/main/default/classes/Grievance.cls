public with sharing class Grievance {
    public static void deleteAll(){
        list<Grievance__c> grev = [select id from Grievance__c];
        
        delete grev;
        system.debug('Deleted all grievances');
    }
    
    public static void delNullPays(){
        list<A_Payment__c> pays = [select id from A_Payment__c where booking__c = null];
        
        delete pays;
        system.debug('deleted null pays');
    }
}