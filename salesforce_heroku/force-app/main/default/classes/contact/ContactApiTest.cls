@isTest
public with sharing class ContactApiTest {
    static final String contactfName = 'test contact fname';
    static final String contactlName = 'test contact lname';


    
    @isTest static void  testCreateNewContact() {
        RestContext.response = new RestResponse();
        Id contactId = ContactApi.create(new Contact(firstName=contactfName, LastName=contactlName, email='salesforce@gmail.com'));
        //Verify the results
        System.assert(contactId != null);
        Contact theContact = [SELECT Id, Email FROM Contact WHERE Id=:contactId];
        System.assert(theContact != null);
        System.assertEquals('salesforce@gmail.com', theContact.Email);
    }
    
    @isTest static void testCreateExistedContact() {
        RestContext.response = new RestResponse();
        Id contactId1 = ContactApi.create(new Contact(firstName=contactfName, LastName=contactlName, email='salesforce@gmail.com'));
        Id contactId2 = ContactApi.create(new Contact(firstName=contactfName, LastName=contactlName, email='salesforce@gmail.com'));


        //Verify the test
        System.assert(contactId1 != null);
        System.assert(contactId2 != null);
        System.assert(contactId1 == contactId2);
        List<Contact> contacts = [SELECT Id, Email FROM Contact WHERE Email='salesforce@gmail.com'];
        System.assert(contacts != null);
        System.assertEquals('salesforce@gmail.com', contacts[0].Email);
        System.assertEquals(1, contacts.size());
    }

    @isTest static void testUpdateContact() {
        RestContext.response = new RestResponse();
        Contact existedContact = ContactService.create(new Contact(firstName=contactfName, lastName=contactlName, email='salesforce@gmail.com' ));
        //mock url request
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mock.salesforce.com/services/apexrest/contacts/'+existedContact.id;
        RestContext.request = request;
        ContactApi.change(new Contact(email='sales@gmail.com'));
        // verify the results
        List<Contact> contacts = [SELECT Id, email FROM Contact WHERE id=: existedContact.id];
        System.assert(contacts != null);
        System.assertEquals('sales@gmail.com', contacts[0].Email);
        System.assertEquals(1, contacts.size());
    }
    //Test to unactive contact after delete from AXG
    @isTest static void testunactiveContact() {
        RestContext.response = new RestResponse();
        Id contactId = ContactApi.create(new Contact(firstName=contactfName, LastName=contactlName, email='salesforce@gmail.com'));
        //mock url request
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mock.salesforce.com/services/apexrest/contacts/'+contactId;
        RestContext.request = request;
        ContactApi.deactivate();
        //Verify the contact is disable and NOT delete
        Contact thisContact = [SELECT Active__c FROM Contact WHERE Id=:contactId];
        System.assert(thisContact != null);
        System.assertEquals(false, thisContact.Active__c);
    }
}