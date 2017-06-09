public abstract class Composite implements Condition {

    public list<Condition> allchildren {get; private set;}
    
    public Composite(){
        this.allchildren = new list<Condition>();
        
    }
    
    //adding new condition to existing (we can add more than two conditons in or , and composite )
    public Condition add(Condition con){
        allchildren.add(con); 
        return this;
    }
    
    public Condition set(String name , Boolean value){
        for(Condition con : allchildren){
            con.set(name , value);
        }
        return this;
        
    }
    
    //only evaluation will be differnt based on OR , AND Composite 
    public abstract Boolean evaluate();
    
    public Boolean hasChildren {get {return !allchildren.isEmpty(); }}
     
}