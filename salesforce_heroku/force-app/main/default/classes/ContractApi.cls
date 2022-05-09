@RestResource(urlMapping='/contracts/*')
global with sharing class ContractApi {
    @HttpPost
    global static Id create(Contract contract) {
        RestContext.response.statusCode = 200;
        return ContractService.create(contract).id;
    }
    @HttpPatch
    global static Id change(Contract contract) {
        RestRequest req = RestContext.request;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        contract.id = id;
        return ContractService.modify(contract).id;
    }
}
