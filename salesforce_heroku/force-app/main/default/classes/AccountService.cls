public with sharing class AccountService {
    public static Account create(Account anAccount) {
        insert anAccount;
        return anAccount;
    }
    public static Account modify(Account anAccount) {
        update anAccount;
        return anAccount;
    }
}
