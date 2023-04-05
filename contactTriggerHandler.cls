public class ContactTriggerHandler {
    public static void sendEmailClass(List<contact> conList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for(Contact con: conList){
            if(con.Email!=null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                string[] toAddress = new string[]{con.Email};
                    emailMsg.setToAddresses(toAddress);
                string emailSub = 'Welcome ' + con.FirstName;
                	emailMsg.setSubject(emailSub);
                string disName = 'Shreyas Reddy';
                	emailMsg.setSenderDisplayName(disName);
                String content = 'Hi ' + con.FirstName + ',<br/><br/>' +
                    'Welcome to Salesforce <br/><br/>'+
                    'Thank you!';
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
    }
}