global with sharing class SDO_Platform_Get_Incident_Problems {
    @InvocableMethod
    global static List<Results> GetIncidentProblems(List<Requests> requests) {
        Results results = new Results();
        results.problems = retrieveIncidentProblems(requests[0].incidentId);
        
        List<Results> resultsList = new List<results>();
        resultsList.add(results);
        return resultsList;
    }
    
    global static List<Problem> retrieveIncidentProblems(String incidentId) {
        List<ProblemIncident> problemIncidents = [SELECT RelatedIssueId FROM ProblemIncident WHERE IssueId = :incidentId];
        
        List<String> problemIds = new List<String>();
        for (ProblemIncident problemIncident: problemIncidents) {
            problemIds.add(problemIncident.RelatedIssueId);
        }
        
        List<Problem> problems = [SELECT Id FROM Problem WHERE Id IN :problemIds];
        
        if (problems.size() == 0) {
            return null;
        }

        return problems;
    }    
    
    global class Requests {
        @InvocableVariable(required=true)
    	global String incidentId;
    }
    
    global class Results {
        @InvocableVariable
    	global List<Problem> problems;
    }
}