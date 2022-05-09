@RestResource(urlMapping='/contacts/*')
global with sharing class ContactApi {

    @HttpPost
    global static Id create(Contact contact) {
        Contact existedContact = ContactService.findByEmail(contact);
        if (existedContact != null) {
            RestContext.response.statusCode = 200;
            return existedContact.id;
        }
        RestContext.response.statusCode = 201;
        return ContactService.create(contact).id;
    }

    @HttpPatch
    global static Id change(Contact contact) {
        RestRequest req = RestContext.request;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Contact existedContact = ContactService.findById(id);

        if (existedContact == null) {
            RestContext.response.statusCode = 404;
            return null;
        }
        contact.id = existedContact.id;
        RestContext.response.statusCode = 200;
        return ContactService.modify(contact).id;
    }

    @HttpDelete
    global static void deactivate() {
        RestRequest req = RestContext.request;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        ContactService.deactivate(id);
    }

}
