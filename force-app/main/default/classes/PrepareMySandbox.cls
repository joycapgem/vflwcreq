global class PrepareMySandbox implements SandboxPostCopy {
    
    global void runApexClass(SandboxContext context) {
       
        StaticResource accountStaticResource = [select Body from StaticResource where Name = 'Account_csv'];
        String accountCsv = accountStaticResource.Body.toString();
        Account[] accountList = new Account[] {};
        for(String row : accountCsv.split('\n')) {
            String[] column = row.split(',');
            accountList.add(
                new Account(
                    Name = column[0],
                    BillingState = column[1],
                    Phone = column[2],
                    Type = column[3]
                )
            );
        }
        insert accountList;
         
        /*
         * Use a Map to avoid creating an unnecessary External ID field on Account
         */
        Map<String, Id> accountMap = new Map<String, Id>();
        for (Account acc : accountList) {
            accountMap.put(acc.Name, acc.Id);
        }
         
        /*
         * Insert related Contacts
         */
        StaticResource contactStaticResource = [select Body from StaticResource
                                                where Name = 'Contact_csv'];
        String contactCsv = contactStaticResource.Body.toString();
        Contact[] contactList = new Contact[] {};
        for(String row : contactCsv.split('\n')) {
            String[] column = row.split(',');
            contactList.add(
                new Contact(
                    FirstName = column[0],
                    LastName = column[1],
                    AccountId = accountMap.get(column[2]),
                    Title = column[3],
                    Phone = column[4],
                    Email = column[5]
                )
            );
        }
        insert contactList;
    }
}