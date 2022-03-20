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
        List<Contact> contacts = [SELECT AccountId FROM Contact WHERE AccountId != NULL];
        List<String> accountIds = new List<String>();
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