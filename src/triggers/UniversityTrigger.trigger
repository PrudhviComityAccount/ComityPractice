/**
 * Creates and assocaites the admin department with the newly created univesities.
 */
trigger UniversityTrigger on Universities__c (after insert) {
    // You might reveice more than one record.
    // which one to associate
    // If you dont get anything
    
    Map<String, DefaultDept__c> defDeptsList = DefaultDept__c.getAll();
    Set<String> UniqueActiveDepts = new Set<String>();
    
    /*
    	Values(), keyset(), get(<key>), put(<key>,<value>) 
    */
    

    List<Department__c> AdminDept = [select Id, Name from Department__c where name = :System.Label.DefaultDept limit 1];
    Department__c dept = new Department__c();
    
    if(AdminDept != null && !AdminDept.isEmpty()) {
        //retrieve the record
        for(Department__c d : AdminDept) {
            dept = d;
        }
        
    } else {
        //create a new dept and associate it with university
        dept = new Department__c(Name = System.Label.DefaultDept);
        
        //DML statement
        insert dept;
    }
    List<Universities__c> UnvList = Trigger.New;
    
    for(Universities__c u : UnvList) {
        //create the junction object record.
        
        /*Narayana Babu tried the following code and it compiled fine*/
        University_Department__c univDept = new University_Department__c();
        univDept.Department__c = dept.Id;
        univDept.University__c = u.Id;
        univDept.Name = u.Name+'_'+dept.Name;
        insert univDept;
    }
}