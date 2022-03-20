// This code is used during demo initialization. It reassigns ownership of All Accounts and Contacts to a sales user. 
// This is necessary because the orchestration sends notifications to the account owners.
// We don't want all of these notifications going to the primary demo user.
// Instead, based on the demo script, our Orchestration notifies the sales teams.
User user = [SELECT Id FROM User WHERE alias='Cindy'];

List<Account> accounts = [SELECT Id, OwnerId FROM Account];
for (Account account: accounts) {
    account.OwnerId = user.Id;
}
update accounts;

List<Contact> contacts = [SELECT Id, OwnerId FROM Contact];
for (Contact contact: contacts) {
    contact.OwnerId = user.Id;
}
update contacts;