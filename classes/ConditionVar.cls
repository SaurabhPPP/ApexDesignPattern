public class ConditionVar implements Condition {
    public string name{get; private set;}
    public Boolean value {get; private set;}
    
    public ConditionVar(String name){
        this.name = name;
    }
    
    //this is not doing any thing in this class , so just returning 
    public condition add(Condition con){return this; }
    
    
    
      //setting  expressions result  value to perticular condition 
    public Condition set(String name , Boolean value){
        
        if(this.name != null && this.name.equalsIgnoreCase(name))
            this.value = value;
        
        return this;
    }
    
    //only evaluation will be differnt based on OR , AND Composite 
    public  Boolean evaluate(){
        
        return value;
    }
}