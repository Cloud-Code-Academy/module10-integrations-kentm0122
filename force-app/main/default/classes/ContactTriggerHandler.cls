public class ContactTriggerHandler {
    public static void beforeInsert(List<Contact> newContacts) {
    // When a contact is inserted
	// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
    List<Contact> contactsToCreate = new List<Contact>();
    for (Contact currContact : newContacts) {
        if (currContact.DummyJSON_Id__c == null) {
            currContact.DummyJSON_Id__c = String.valueOf(Math.floor(Math.random() * 100));
            contactsToCreate.add(currContact);
        }
   
    }
    if (!contactsToCreate.isEmpty()) {
        insert contactsToCreate;
        List<String> ids = new List<String>();
        for (Contact currContact : contactsToCreate) {
            if (Integer.valueOf(currContact.DummyJSON_Id__c) <= 100) {
                ids.add(currContact.DummyJSON_Id__c);
            }
        }
        callDummyjson(ids);
    }
    

    }
    @future
    public static void callDummyjson(List<String> ids) {
        for (String currId : ids) {
            DummyJSONCallout.getDummyJSONUserFromId(currId);
        }

    }
}