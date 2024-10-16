# Create the scratch org (uncomment for the SFDX Deployer)
sf demoutil org create scratch -f config/project-scratch-def.json -d 5 -s -p flow -e orchestrator.demo

# Push the metadata into the new scratch org.
sf project deploy start 

# Import the data required by the demo
# (Exported using 'sfdx automig:dump --objects Account,Contact --outputdir ./data')
sf automig load --inputdir ./data --deletebeforeload

# Assign the permset to the default admin user.
sf org assign permset -n SDO_Platform_Demos

sf apex run -f ./scripts/createUsers.apex

# Create the other users used by this demo
# sf org create user -f config/quentin-user.json
# sf org create user FirstName="Quentin" LastName="Engineer" Alias="Quentin" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sfdx force:user:create FirstName="Quentin" LastName="Engineer" Alias="Quentin" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sfdx shane:user:photo -f ./photos/quentin.png -g Quentin -l Engineer
# sf org create user FirstName="Tim" LastName="Service" Alias="Tim" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sfdx force:user:create FirstName="Tim" LastName="Service" Alias="Tim" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sf org create user -f config/tim-user.json
# sfdx shane:user:photo -f ./photos/tim.png -g Tim -l Service
# sf org create user FirstName="Sue" LastName="Marketing" Alias="Sue" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sfdx force:user:create FirstName="Sue" LastName="Marketing" Alias="Sue" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sf org create user -f config/sue-user.json
# sfdx shane:user:photo -f ./photos/sue.png -g Sue -l Marketing
# sf org create user FirstName="Cindy" LastName="Sales" Alias="Cindy" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sfdx force:user:create FirstName="Cindy" LastName="Sales" Alias="Cindy" profileName="System Administrator" permsets="SDO_Platform_Demos"
# sf org create user -f config/cindy-user.json
# sfdx shane:user:photo -f ./photos/cindy.png -g Cindy -l Sales

# Reassign ownership of ALL Accounts and Contacts to the 'Cindy' sales user.
sf apex run -f ./scripts/ReassignAllAccountsAndContacts.apex

# Generate a new Incident and related Cases
sf apex run -f ./scripts/GenerateIncident.apex

# Set the default password.
sf demoutil user password set -p salesforce1 -g User -l User

# Open the demo org.
sf org open
