@istest
public with sharing class LeadingCompetitorTest {
    @istest
    public static void testCompetitor() {
        Opportunity op = new Opportunity();
        op.Name = 'new opp';
        op.StageName = 'Prospecting';
        op.CloseDate = date.today().addDays(10);
        op.competitor_1_price__c = 1000;
        op.competitor_2_price__c = 500;
        op.competitor_3_price__c = 2000;
        
        op.competitor_1__c = 'Amazon';
        op.competitor_2__c = 'Google';
        op.competitor_3__c = 'Microsoft';

        insert op;

        Opportunity sop = [select Id, leading_competitor__c from Opportunity where Name = 'New opp' limit 1];

        system.assertEquals('Google', sop.leading_competitor__c, 'equal');
    }
}