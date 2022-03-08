@isTest
public class HelloWorldTest {
	@isTest
    static void updateLead(){
        lead l = new lead();
        l.FirstName = 'Jaya Kumar';
        l.LastName = 'Talla';
        l.company = 'Google';
        
        insert l;
        
        l.company = 'Microsoft';
        
        update l;
    }
}