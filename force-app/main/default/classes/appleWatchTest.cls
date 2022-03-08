@isTest
public class appleWatchTest {
    @isTest static void createOpportunity(){
        opportunity opp = new Opportunity();
        opp.name = 'Swift Deal';
        opp.StageName = 'Prospecting';
        opp.CloseDate = date.today();
        
        insert opp;
        
    }
    
}