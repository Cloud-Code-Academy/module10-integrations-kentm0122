public class ContactTriggerHandler {
    private static Boolean isExecuting = false;

    public static void beforeInsert(List<Contact> newContacts) {
    // When a contact is inserted
	// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
    List<Contact> contactsToCreate = new List<Contact>();
        for (Contact currContact : newContacts) {
            if (currContact.DummyJSON_Id__c == null) {
            currContact.DummyJSON_Id__c = String.valueOf(Integer.valueOf(Math.floor(Math.random() * 100)));
            }
            if (Integer.valueOf(currContact.DummyJSON_Id__c) <= 100) {
                DummyJSONUserFromId(currContact.DummyJSON_Id__c);
            
            }
        }
    } 


    public static void beforeUpdate(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
            for (Contact currContact : newContacts) {
                Contact oldCon = oldContactsMap.get(currContact.Id);
                if (currContact.DummyJSON_Id__c != null && Integer.valueOf(currContact.DummyJSON_Id__c) > 100 && currContact.DummyJSON_Id__c != oldCon.DummyJSON_Id__c) {
                    DummyJSONUser(currContact.Id);
                }
            }
    }
    
    @future (callout=true)
    private static void DummyJSONUserFromId(String jsonId) {
        DummyJSONCallout.getDummyJSONUserFromId(jsonId);
    }

    @future (callout=true)
    private static void DummyJSONUser(String contactId) {
        DummyJSONCallout.postCreateDummyJSONUser(contactId);
    }
}