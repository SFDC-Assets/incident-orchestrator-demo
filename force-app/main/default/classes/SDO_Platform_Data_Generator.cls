public class SDO_Platform_Data_Generator {
	public static void DeleteAllIncidents() {
        List<Incident> incidents = [SELECT Id FROM Incident];
        
    }
}