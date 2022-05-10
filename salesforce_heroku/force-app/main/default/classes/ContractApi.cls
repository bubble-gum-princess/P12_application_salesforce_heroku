@RestResource(urlMapping='/contracts/*')
global with sharing class ContractApi {
    @HttpPost
    global static String create(Contract contract) {
        RestContext.response.statusCode = 201;
        try {
            return ContractService.create(contract).id;
        } catch(MissingFieldException e) {
            RestContext.response.statusCode = 400;
            return e.getMessage();
        }
    }
    @HttpPatch
    global static Id change(Contract contract) {
        RestRequest req = RestContext.request;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        contract.id = id;
        return ContractService.modify(contract).id;
    }
}
