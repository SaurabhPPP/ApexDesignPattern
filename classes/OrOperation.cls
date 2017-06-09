/*
 *  If any of conditon is True OROperation will return false 
 */

public class OrOperation extends Composite{
    
    public override  Boolean evaluate(){
        
        for(Condition con : allchildren){
            if(con.evaluate())
                return true;
        }
        return false;        
    }

}