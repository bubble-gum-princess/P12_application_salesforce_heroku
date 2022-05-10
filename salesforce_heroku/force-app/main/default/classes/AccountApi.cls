@RestResource(urlMapping='/accounts/*')
global with sharing class AccountApi {
   @HttpPost
    global static Id create(Account account) {
        RestContext.response.statusCode = 201;
        return AccountService.create(account).id;
    }
    @HttpPatch
    global static Id change(Account account) {
        RestRequest req = RestContext.request;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        account.id = id;
        return AccountService.modify(account).id;
    }
}

