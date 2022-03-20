global with sharing class SDO_Platform_Get_Random_Number {
    
    @InvocableMethod
    global static List<Results> getRandomNumberFromRange(List<Requests> requests) {
        Results curResult = new Results();
        curResult.randomNumber = generateRandomFromRange(requests[0].startNumber, requests[0].endNumber);
        
        List<Results> resultsList = new List<results>();
        resultsList.add(curResult);
        return resultsList;
    }

    global static Integer generateRandomFromRange(Integer lowerLimit, Integer upperLimit) {
        Integer rand = Math.round(Math.random() * (upperLimit - lowerLimit)) + lowerLimit;
        return rand;
    }
    
    global class Requests {
        @InvocableVariable(required=true)
    	global Integer startNumber;
        
        @InvocableVariable(required=true)
    	global Integer endNumber;
    }
    
    global class Results {
        @InvocableVariable
    	global Integer randomNumber;
    }
}