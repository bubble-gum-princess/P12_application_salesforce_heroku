public with sharing class ContactService {

    public static Contact findByEmail(Contact aContact) {
        contact[] contacts = [SELECT Id FROM Contact WHERE email=:aContact.email];
        return contacts.isEmpty() ? null : contacts[0];
    }
    public static Contact findById (String id) {
        return [SELECT Id FROM Contact WHERE Id=:id];
    }

    public static Contact create(Contact aContact) {
        insert aContact;
        return aContact;
    }

    public static Contact modify(Contact aContact) {
        update aContact;
        return aContact;
    }

    public static void deactivate(String id) {
        contact aContact = [SELECT Id, Active__c FROM Contact WHERE id = :id];
        if (aContact != null && aContact.Active__c) {
             aContact.Active__c = false;
             update aContact;

        }
    }

}
