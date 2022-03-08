@isTest
public with sharing class DedupeLeadTest {
    @isTest
    public static void tm1() {
        string leadOwner = userInfo.getUserId();

        Lead myLead = new Lead();
        myLead.FirstName = 'Sansa';
        myLead.LastName = 'Stark';
        myLead.Company = 'Winterfell Hotels';
        myLead.Email = 'sstark@winterfellhotels.com';
        myLead.Description = 'The North Remembers';
        myLead.OwnerId = UserInfo.getUserId();

        insert myLead;

        Lead updatedLead = [Select OwnerId, Description
                            from Lead
                            where Id = :myLead.Id];

        system.assertEquals(leadOwner, updatedLead.OwnerId);
        system.assertEquals(myLead.Description, updatedLead.Description);
    }

    @isTest
    public static void tm2(){
        string email = 'sstark@winterfellhotels.com';

        List<Contact> dupeComtacts = new List<Contact>();
        contact firstDupe = new contact();
        firstDupe.firstName = 'Sansa';
        firstDupe.LastName = 'Stark';
        firstDupe.email = email;
        dupeComtacts.add(firstDupe);

        contact secondDupe = new Contact();
        secondDupe.firstName = 'Sansa';
        secondDupe.LastName = 'Stark';
        secondDupe.email = email;
        dupeComtacts.add(secondDupe);

        insert dupeComtacts;

        lead myLead = new lead();
        myLead.FirstName = 'Sansa';
        myLead.lastName = 'Stark';
        myLead.Company = 'Winterfell Hotels';
        myLead.Email = email;
        myLead.OwnerId = UserInfo.getUserId();
        myLead.Description = 'The North Remembers';

        insert myLead;

        lead updatedLead = [select ownerId, description from lead where id = :myLead.Id];

        group dataQualityQueue = [Select Id from group where developerName = 'Data_Quality' limit 1];

        system.assertEquals(dataQualityQueue.Id, updatedLead.OwnerId);
        system.assert(updatedLead.Description.contains(firstDupe.Id));


    }
}