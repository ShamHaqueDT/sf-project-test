public with sharing class AccountProcessor {
        @future
        public static void countContacts(List<Id> accountIds) {
            List<Account> accList = [SELECT Id, Number_Of_Contacts__c
                                    FROM Account
                                    WHERE Id IN :accountIds];
        
            List<Account> accUpdates = new List<Account>();

            for(Account a : accList) {
                Integer c = [SELECT COUNT()
                            FROM Contact, Contact.Account
                            WHERE AccountId = :a];
                a.Number_Of_Contacts__c = c;
                accUpdates.add(a);
                
            }

            update accUpdates;
        }
    }