public class ClientForComposite {
    
    public static void  myexpressionTraditional(List<Opportunity> listOpp , Map<Id , Opportunity> oldMap ){
    //when we making a oppotunity Closed own , then it's account should not be null and ( account employee > 4000  OR Ownership = public Or 	Annual Revenue > $100000) and no. of contact on account> 1
    // ANd ((Opportunity Type = new customer AND Lead Source = WEb) OR Opportunity Type Contains Existing Customer )))
            Map<Id ,Opportunity>  mapOfOpptyClosed = new  Map<Id ,Opportunity>();
           
         // Condition for valid Oppertunity which closed Won 
            Condition optyChangedtoClosedOwn = new AndOperation();
            optyChangedtoClosedOwn.add(new ConditionVar('OptyChangedtoClosedOwn'));
            optyChangedtoClosedOwn.add(new ConditionVar('changedFromPreviousValue'));
            optyChangedtoClosedOwn.add(new ConditionVar('accountNotNull'));
            Condition opportunityValid = new OrOperation();
            opportunityValid.add(new ConditionVar('NewCustomerShouldBeWeb'));
            opportunityValid.add(new ConditionVar('ExistingCustomer'));
            optyChangedtoClosedOwn.add(opportunityValid);
          // Condition for valid Oppertunity which closed Won 
          
        
        
          // Condition for valid Account for Opportunity 
            Condition correctAccount = new AndOperation();
            correctAccount.add(new ConditionVar('NoOfContact'));
            //Or Condition 
            Condition correctAccountData = new OrOperation();
            correctAccountData.add(new ConditionVar('employeeCount'));
            correctAccountData.add(new ConditionVar('OwnerShip'));
            correctAccountData.add(new ConditionVar('AnnualRevenue'));
            correctAccount.add(correctAccountData);
           // Condition for valid Account for Opportunity 
  
        
        
        
        For(Opportunity opp : listOpp){
             optyChangedtoClosedOwn.set('OptyChangedtoClosedOwn' , opp.StageName == 'Closed Won' );
             optyChangedtoClosedOwn.set('changedFromPreviousValue' , oldMap.containsKey(opp.id) && oldMap.get(opp.id).stageName != opp.StageName  ); 
             optyChangedtoClosedOwn.set('accountNotNull' , opp.AccountId != null);
             optyChangedtoClosedOwn.set('NewCustomerShouldBeWeb' , opp.Type == 'New Customer' && opp.LeadSource == 'Web');
             optyChangedtoClosedOwn.set('ExistingCustomer' , opp.Type.containsIgnoreCase('Existing Customer'));
            
            
             If(optyChangedtoClosedOwn.evaluate())
                mapOfOpptyClosed.put(opp.AccountId , opp); 
            
        }
        
         for(Account acc : [Select Id , NumberOfEmployees,Ownership,AnnualRevenue, (Select Id from Contacts) from Account where Id in :mapOfOpptyClosed.keyset()]){
              correctAccount.set('NoOfContact', acc.Contacts != null && acc.Contacts.size() > 0);
              correctAccount.set('employeeCount', acc.NumberOfEmployees >100);
              correctAccount.set('OwnerShip' ,acc.Ownership =='Public');
              correctAccount.set('AnnualRevenue' , acc.AnnualRevenue >10000);      
               
             If(correctAccount.evaluate()){
                 mapOfOpptyClosed.get(acc.Id).status__c = 'ClosedOpportunity';
             }
             else{
                   mapOfOpptyClosed.get(acc.Id).status__c = 'OpenOpportunity';
                   mapOfOpptyClosed.get(acc.Id).StageName = 'Needs Analysis';
             }
             
        }
        
     }

}