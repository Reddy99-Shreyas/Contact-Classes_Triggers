public class CountContactTriggerHandler {
    
    //whenever contact getting "INSERTED", we need to increment the value on Account object(No of Contacts field)
    public static void aftIns(List<contact>conList){
        set<Id> accIds = new set<Id>();
        for(Contact con: conList){
            accIds.add(con.AccountId);
        }
        List<Account> accsOfRelatedContact = [SELECT Id, no_Of_Contacts__c,Sum_of_Amount_Contacts__c,(Select Id,Amount__c FROM Contacts) FROM Account WHERE Id IN:accIds];
        for(Account acc:accsOfRelatedContact){
            acc.no_Of_Contacts__c=acc.contacts.size();
            Decimal sumOfAllAmounts = 0;
            for(Contact con:acc.contacts){
                sumOfAllAmounts = sumOfAllAmounts + con.Amount__c;
            }
            acc.Sum_of_Amount_Contacts__c = sumOfAllAmounts;
        }
        update accsOfRelatedContact;
    }
    
    //when Ever contact getting "DELETED" we need to decrement the value on Account Record(No of Contacts field)
    public static void aftDel(List<contact>conOldList){
        set<Id>accIds = new Set<Id>();
        for(Contact con: conOldList){
            accIds.add(con.AccountId);
        }
        List<Account> accsOfRelatedContact = [SELECT Id, no_Of_Contacts__c,Sum_of_Amount_Contacts__c,(Select Id,Amount__c FROM Contacts) FROM Account WHERE Id IN:accIds];
        for(Account acc:accsOfRelatedContact){
            acc.no_Of_Contacts__c=acc.Contacts.size();
            Decimal sumOfAllAmounts = 0;
            for(Contact con:acc.contacts){
                sumOfAllAmounts = sumOfAllAmounts + con.Amount__c;
            }
            acc.Sum_of_Amount_Contacts__c = sumOfAllAmounts;
        }
        update accsOfRelatedContact;
    }
    
    //when ever contact getting "UNDELETED" we need to increment the value on Account record1(No of Contacts field)
    public static void aftUnDel(List<contact>conList){
        set<Id> accIds = new set<Id>();
        for(Contact con: conList){
            accIds.add(con.AccountId);
        }
        List<Account> accsOfRelatedContact = [SELECT Id, no_Of_Contacts__c,Sum_of_Amount_Contacts__c,(Select Id,Amount__c FROM Contacts) FROM Account WHERE Id IN:accIds];
        for(Account acc:accsOfRelatedContact){
            acc.no_Of_Contacts__c=acc.contacts.size();
            Decimal sumOfAllAmounts = 0;
            for(Contact con:acc.contacts){
                sumOfAllAmounts = sumOfAllAmounts + con.Amount__c;
            }
            acc.Sum_of_Amount_Contacts__c = sumOfAllAmounts;
        }
        update accsOfRelatedContact;
    }
    
    //when ever contact gets "REPARENTED", we need to decrement the value on Account Record1(No of Contacts field) and increment the value on Account Record2(No of Contacts field)
    public static void aftUpdate(List<contact>conList, map<Id,contact> conMap){
        set<Id> accIds = new set<Id>();
        for(contact con: conList){
            accIds.add(con.AccountId);//contact's account changed from account1 to account2, con.AccountId will have latest values(i.e. Account2)
            contact oldValuesOnThatContact = conMap.get(con.Id);
            accIds.add(oldValuesOnThatContact.AccountId);//contact's with old Account value, oldValuesOnThatContact.AccountId having old value(i.e. Account1)
        }
        List<Account> accsOfRelatedContact = [SELECT Id, no_Of_Contacts__c,Sum_of_Amount_Contacts__c,(Select Id,Amount__c FROM Contacts) FROM Account WHERE Id IN:accIds];
        for(Account acc:accsOfRelatedContact){
            acc.no_Of_Contacts__c=acc.contacts.size();
            Decimal sumOfAllAmounts = 0;
            for(Contact con:acc.contacts){
                sumOfAllAmounts = sumOfAllAmounts + con.Amount__c;
            }
            acc.Sum_of_Amount_Contacts__c = sumOfAllAmounts;
        }
        update accsOfRelatedContact;
    }
    
}