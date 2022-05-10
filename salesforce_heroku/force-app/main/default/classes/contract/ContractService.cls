public with sharing class ContractService {
    public static Contract create(Contract aContract) {
        if (aContract.accountId == null) {
            throw new MissingFieldException('missing accountId');
        }
        insert aContract;
        return aContract;
    }
    public static Contract modify(Contract aContract) {
        update aContract;
        return aContract;
    }
}
