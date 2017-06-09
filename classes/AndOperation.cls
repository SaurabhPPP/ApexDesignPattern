/*
 *  If any of conditon is false AndOperation will return false 
 */
 
public class AndOperation extends Composite {
    
    public override  Boolean evaluate(){
        
        for(Condition con : allchildren){
            if(!con.evaluate())
                return false;
        }
        return true;        
    }

}