public class DecoratorController {

    public PageReference saveIt() {
    
        If(listOfMerchandise != null)
        {
             List<Merchandise__c> listMerchandise = new List<Merchandise__c  >();
             for(MerchandiseWrapper merc : listOfMerchandise ){
                 listMerchandise.add(merc.merchandise);
                
             }
             upsert  listMerchandise ;
         
        }
        
        return null;
    }


    
     public Decimal Total {get; set;}
     public List<MerchandiseWrapper> listOfMerchandise { get{
     
          if(listOfMerchandise == null){
              listOfMerchandise  = new List<MerchandiseWrapper>();
              
              for(Merchandise__c  merchandise :  [Select Id , Name ,price__c from Merchandise__c limit  10 ]){
              
                  listOfMerchandise.add(new MerchandiseWrapper(merchandise));
                  
                  
              
               }
              
           } 
      return listOfMerchandise ;
      } private set; }
     
     
    
     public Decimal dTRs(Decimal dollor){
     
     return  dollor*72 ;
    }
    
     public Decimal RsTD(Decimal Ruppes){
     
     return  Ruppes/72 ;
     }
    
    
    //wrapper class Inner class
    public class  MerchandiseWrapper {
        
        public Decimal previousValue { get; set; }
        public Merchandise__c merchandise {get; Private set;}
        
        public MerchandiseWrapper(Merchandise__c merchandise  ){
            this.merchandise  = merchandise ;
        }
        public Decimal priceInRs {get {
          if( merchandise != null  ){
            priceInRs = new DecoratorController().dTRs(merchandise.price__c);
          }
          
          return priceInRs;
         }
        
        set{
             If(merchandise != null && value != null){
                 previousValue  =   merchandise.price__c;
                 merchandise.price__c = new DecoratorController().RsTD(value);
                 //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING , 'This is warning '));
             }
        } 
    
       } 
    }
    
    
}