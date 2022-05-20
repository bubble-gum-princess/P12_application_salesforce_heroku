public with sharing class AccountService {
    public static Account create(Account anAccount) {
        insert anAccount;
        return anAccount;
    }
    public static Account findByName(String name) {
        Account[] accounts = [SELECT Id FROM Account WHERE name=:name];
        return accounts.isEmpty() ? null : accounts[0];
    }
    public static Contact findById (String id) {
        return [SELECT Id FROM Contact WHERE Id=:id];
    }
    public static Account modify(Account anAccount) {
        update anAccount;
        return anAccount;
    }
}
