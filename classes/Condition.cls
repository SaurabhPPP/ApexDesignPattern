public Interface Condition {
    
    //Method define for evaluation and adding different conditions 
    Condition add(Condition con);
    Condition set(String name ,Boolean value);
    Boolean evaluate();

}