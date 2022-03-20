global with sharing class SDO_Platform_Get_Random_Account_Contact {

    @InvocableMethod
    global static List<Results> GetRandomAccountContact(List<Requests> requests) {
        Results results = new Results();
        results.contactId = RetrieveRandomAccountContact(requests[0].accountId);
        
        List<Results> resultsList = new List<results>();
        resultsList.add(results);
        return resultsList;
    }
    
    global static String RetrieveRandomAccountContact(String accountId) {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :accountId];
        
        if (contacts.size() == 0) {
            return null;
        }
        
        Integer randomNumber = SDO_Platform_Get_Random_Number.generateRandomFromRange(0, contacts.size() - 1);
        
        return contacts[randomNumber].Id;
    }    
    
    global class Requests {
        @InvocableVariable(required=true)
    	global String accountId;
    }
    
    global class Results {
        @InvocableVariable
    	global string contactId;
    }
}