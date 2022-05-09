public with sharing class ContractService {
    public static Contract create(Contract aContract) {
        insert aContract;
        return aContract;
    }
    public static Contract modify(Contract aContract) {
        update aContract;
        return aContract;
    }
}
