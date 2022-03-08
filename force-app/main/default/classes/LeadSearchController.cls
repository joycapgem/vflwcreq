public with sharing class LeadSearchController {
    @AuraEnabled(cacheable=true)
    public static list<lead> searchLeads(string searchTerm) {
        list<lead> leads = new list<lead>();
        if(string.isNotBlank(searchTerm)){
            List<List<SObject>> searchResults = [
                                                    FIND :searchTerm
                                                    RETURNING Lead(
                                                        Id, Name, Title, Company, Street, City, State, PostalCode ORDER BY NAME LIMIT 10
                                                    )
                                                ];
            leads = searchResults[0];
        }

        return leads;
    }
}