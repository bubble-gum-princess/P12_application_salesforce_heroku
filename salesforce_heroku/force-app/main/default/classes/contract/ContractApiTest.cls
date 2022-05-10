@isTest
public with sharing class ContractApiTest {
    static final String accountName = 'test account name';

    @isTest static void testCreateContract() {
        RestContext.response = new RestResponse();
        Account account = AccountService.create(new Account (name=accountName));
        Id theContractId = ContractApi.create(new Contract (accountId= account.Id, status='Draft') );
        // verifying the results
        System.assertEquals(201, RestContext.response.statusCode);
        System.assert(theContractId != null);
        Contract thisContract = [SELECT accountId FROM Contract WHERE Id=:theContractId];
        System.assert(theContractId != null);
        System.assertEquals(account.id, thisContract.accountId);
    }
    @isTest static void testUpdateContract() {
        Account account = AccountService.create(new Account (name=accountName));
        Contract existedContract = ContractService.create(new Contract (accountId= account.Id, status='Draft') );
        
        //mock url request
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mock.salesforce.com/services/apexrest/contracts/'+existedContract.id;
        RestContext.request = request;

        ContractApi.change(new Contract(Status='Activated'));
        
        
        //Verifying results
        Contract theContract = [SELECT Status FROM Contract WHERE Id=:existedContract.id];
        System.assert(theContract != null);
        System.assertEquals('Activated', theContract.Status);
    }
}