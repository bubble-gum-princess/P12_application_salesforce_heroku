@isTest
public with sharing class AccountApiTest {
    static final String accountName = 'test account name';

    @isTest static void  testCreateNewAccount() {
        RestContext.response = new RestResponse();
        Id accountId = AccountApi.create(new Account(name=accountName));
        
        //Verify the test
        System.assert(accountId != null);
        Account thisAccount = [SELECT Name FROM Account WHERE Id=:accountId];
        System.assert(thisAccount != null);
        System.assertEquals(accountName, thisAccount.Name);
    }

    @isTest static void testCreateExistedAccount() {
        RestContext.response = new RestResponse();
        Id accountId1 = AccountApi.create(new Account(name=accountName));
        //Recall the method to test with same param
        Id accountId2 = AccountApi.create(new Account(name=accountName));

        System.assert(accountId1 != null);
        System.assert(accountId2 != null);
        System.assert(accountId1 == accountId2);
        List<Account> Accounts = [SELECT Id FROM Account WHERE Name=:accountName];
        System.assert(Accounts != null);
        System.assertEquals(1, Accounts.size());
    }

    @isTest static void testUpdateAccount() {
        String phone = '0123456789';
        Account existedAccount = AccountService.create(new Account(name=accountName));
        
        //mock url request
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mock.salesforce.com/services/apexrest/accounts/'+existedAccount.id;
        RestContext.request = request;
  
        AccountApi.modify(new Account(phone=phone));

        Account theAccount = [SELECT Id, name, phone FROM Account WHERE id=: existedAccount.id];
        System.assert(theAccount != null);
        System.assertEquals(theAccount.name, accountName);
        System.assertEquals(theAccount.phone, phone);
    }
}
