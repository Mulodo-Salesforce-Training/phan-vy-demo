trigger EmailConfirmSender on Job_Application__c (after insert, after update) {
	Set<Id> candidates = new Set<Id>();

	for (Job_Application__c jobApp:Trigger.New) {
		Boolean flagUpdated = true;
		if (Trigger.isUpdate) {
			Job_Application__c oldJobApp = Trigger.oldMap.get(jobApp.Id);
			if (oldJobApp.Status__c == jobApp.Status__c) {
				flagUpdated = false;
			}
		}
		if (jobApp.Status__c == 'Extend an Offer' && flagUpdated) {
			candidates.add(jobApp.Candidate__c);
			/*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {candidate.Email__c};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Candidate Confirmation');
	        mail.setPlainTextBody('Dear '+ candidate.Last_Name__c +'\nThank you for joining our interview. We would like to invite you to join our company, please check our offer details in attachment file and send your confirmation about this.\n\nThank you for reading this mail.');
	        mails.add(mail);*/
		}
	}
	if (candidates.size() > 0) {
		List<Candidate__c> lstCandidate = [SELECT Id, Email__c, First_Name__c FROM Candidate__c WHERE Id IN :candidates];
		EmailManager.sendConfirmEmails(lstCandidate, 'phan.vy@mulodo.com');
	}
	
}