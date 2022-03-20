global with sharing class SDO_Platform_Get_Random_String {
    @InvocableMethod
    global static List<Results> getRandomString(List<Requests> requests) {
        Results results = new Results();
        results.returnString = returnRandomString(requests[0].stringCollection);
        
        List<Results> resultsList = new List<results>();
        resultsList.add(results);
        return resultsList;
    }
    
    global static String returnRandomString(List<String> collection) {
        return collection[SDO_Platform_Get_Random_Number.generateRandomFromRange(0, collection.size() - 1)];
    }

    
    global class Requests {
        @InvocableVariable(required=true)
    	global List<String> stringCollection;
    }
    
    global class Results {
        @InvocableVariable
    	global String returnString;
    }
}