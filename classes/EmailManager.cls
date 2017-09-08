public class EmailManager {

    public static void sendConfirmEmails(List<Candidate__c> lstCandidates) {
    	List<Messaging.SingleEmailMessage> lstMail = new List<Messaging.SingleEmailMessage>();
    	EmailTemplate templateId = [SELECT Id FROM EmailTemplate WHERE Name = 'Candidate Confirm' LIMIT 1];
  
    	for (Candidate__c candidate: lstCandidates) {
    		Messaging.SingleEmailMessage mail =  Messaging.renderStoredEmailTemplate(templateId.Id, candidate.OwnerID, candidate.Id);
			String[] toAddresses = new String[] {candidate.Email__c};
	        mail.setToAddresses(toAddresses);
			mail.setSaveAsActivity(false);
	       	lstMail.add(mail);
    	}
		Messaging.SendEmailResult [] r = Messaging.sendEmail(lstMail);
		System.debug(r);
    }
}