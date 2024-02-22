# Create the scratch org (uncomment for the SFDX Deployer)
sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s -n --userprefix admin --userdomain orchestrator.demo

# Push the metadata into the new scratch org.
sfdx force:source:push

# Import the data required by the demo
# (Exported using 'sfdx automig:dump --objects Account,Contact --outputdir ./data')
sfdx automig:load --inputdir ./data --deletebeforeload

# Assign the permset to the default admin user.
sfdx force:user:permset:assign -n SDO_Platform_Demos

# Create the other users used by this demo
# sf org create user -f config/quentin-user.json
sfdx force:user:create FirstName="Quentin" LastName="Engineer" Alias="Quentin" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sfdx shane:user:photo -f ./photos/quentin.png -g Quentin -l Engineer
sfdx force:user:create FirstName="Tim" LastName="Service" Alias="Tim" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sf org create user -f config/tim-user.json
# sfdx shane:user:photo -f ./photos/tim.png -g Tim -l Service
sfdx force:user:create FirstName="Sue" LastName="Marketing" Alias="Sue" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sf org create user -f config/sue-user.json
# sfdx shane:user:photo -f ./photos/sue.png -g Sue -l Marketing
sfdx force:user:create FirstName="Cindy" LastName="Sales" Alias="Cindy" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sf org create user -f config/cindy-user.json
# sfdx shane:user:photo -f ./photos/cindy.png -g Cindy -l Sales

# Reassign ownership of ALL Accounts and Contacts to the 'Cindy' sales user.
sfdx force:apex:execute -f ./scripts/ReassignAllAccountsAndContacts.apex

# Generate a new Incident and related Cases
sfdx force:apex:execute -f ./scripts/GenerateIncident.apex

# Set the default password.
sfdx shane:user:password:set -g User -l User -p salesforce1

# Open the demo org.
sfdx force:org:open