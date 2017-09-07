public class EmailManager {

    public static void sendConfirmEmails(List<Candidate__c> lstCandidates, String replyAdress) {
    	List<Messaging.SingleEmailMessage> lstMail = new List<Messaging.SingleEmailMessage>();
    	EmailTemplate templateId = [SELECT Id FROM EmailTemplate WHERE Name = 'Interview Confirm' LIMIT 1];
  
    	for (Candidate__c candidate: lstCandidates) {
    		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			mail.setReplyTo(replyAdress);
			String[] toAddresses = new String[] {candidate.Email__c};
	        mail.setToAddresses(toAddresses);
	       /* mail.setTemplateID(templateId.Id); 
			mail.setTargetObjectId(candidate.LastModifiedById);
			mail.setWhatId(candidate.Id);*/
			mail.setSubject('Candidate Confirmation');
	        mail.setPlainTextBody('Dear '+ candidate.First_Name__c +'\nThank you for joining our interview. We would like to invite you to join our company, please check our offer details in attachment file and send your confirmation about this.\n\nThank you for reading this mail.');
	     
			mail.setSaveAsActivity(false);
	       	lstMail.add(mail);
    	}
		Messaging.sendEmail(lstMail);
    }
}