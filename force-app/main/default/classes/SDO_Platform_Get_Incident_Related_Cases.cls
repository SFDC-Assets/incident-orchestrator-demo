global with sharing class SDO_Platform_Get_Incident_Related_Cases {
    @InvocableMethod
    global static List<Results> GetIncidentRelatedCases(List<Requests> requests) {
        Results results = new Results();
        results.cases = retrieveIncidentRelatedCases(requests[0].incidentId);
        
        List<Results> resultsList = new List<Results>();
        resultsList.add(results);
        return resultsList;
    }
    
    global static List<Case> retrieveIncidentRelatedCases(String incidentId) {
        List<CaseRelatedIssue> caseRelatedIssues = [SELECT CaseId FROM CaseRelatedIssue WHERE RelatedIssueId = :incidentId];
        
        List<String> caseIds = new List<String>();
        for (CaseRelatedIssue caseRelatedIssue: CaseRelatedIssues) {
            caseIds.add(caseRelatedIssue.CaseId);
        }
        
        if (caseIds.size() == 0) {
            return null;
        }      
        
        List<Case> cases = [SELECT Id, Status, Account.OwnerId, Account.Name, Contact.FirstName, ContactEmail FROM Case WHERE Id IN :caseIds];
        
        if (cases.size() == 0) {
            return null;
        }

        return cases;
    }    
    
    global class Requests {
        @InvocableVariable(required=true)
    	global String incidentId;
    }
    
    global class Results {
        @InvocableVariable
    	global List<Case> cases;
    }
}