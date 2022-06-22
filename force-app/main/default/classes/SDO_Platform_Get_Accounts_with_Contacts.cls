global with sharing class SDO_Platform_Get_Accounts_with_Contacts {

    @InvocableMethod
    global static List<Results> GetAccountsWithContacts() {
        Results results = new Results();
        results.accounts = retrieveAccountsWithContacts();
        
        List<Results> resultsList = new List<Results>();
        resultsList.add(results);
        return resultsList;
    }
    
    global static List<Account> retrieveAccountsWithContacts() {
        List<String> accountIds = new List<String>();

        // Used for SDO to ensure Cindy Central has Incident Cases
        List<Contact> contacts = [SELECT AccountId FROM Contact WHERE Email = 'sjeffries@example.com' OR Email = 'rreid@example.com' OR Email = 'ehennessy@example.com'];
        for (Contact contact: contacts) {
            accountIds.add(contact.AccountId);
        }

        // Generates random Incident Cases for other Account Owners.
        contacts = [SELECT AccountId FROM Contact WHERE AccountId != NULL];
        for (Contact contact: contacts) {
            accountIds.add(contact.AccountId);
        }
        
        String userId = UserInfo.getUserId();
        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :accountIds AND OwnerId != :userId ];
                
        if (accounts.size() == 0) {
            return null;
        }

        return accounts;
    }    
    
    global class Results {
        @InvocableVariable
    	global List<Account> accounts;
    }
}