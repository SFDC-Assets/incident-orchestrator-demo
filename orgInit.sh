# Deploy the metadata into the new scratch org.
sfdx force:source:deploy -p force-app

# Assign the permset to the default admin user.
sfdx force:user:permset:assign -n SDO_Platform_Demos

# Assign permset to SDO users.
sfdx shane:user:permset:assign -n SDO_Platform_Demos -g Quentin -l Engineer
sfdx shane:user:permset:assign -n SDO_Platform_Demos -g Tim -l Service
sfdx shane:user:permset:assign -n SDO_Platform_Demos -g Sue -l Marketing
sfdx shane:user:permset:assign -n SDO_Platform_Demos -g Cindy -l Sales

# Generate a new Incident and related Cases
sfdx force:apex:execute -f ./scripts/GenerateIncident.apex

# Open the demo org.
sfdx force:org:open