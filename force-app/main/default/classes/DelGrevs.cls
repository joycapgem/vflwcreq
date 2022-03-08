public class DelGrevs {
    public static void del(){
        list<Grievance__c> grevs = [select Id from Grievance__c where Booking__c = null];
        system.debug(grevs.size());
        
        delete grevs;
    }
}