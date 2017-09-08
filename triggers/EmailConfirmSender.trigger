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
		}
	}
	if (candidates.size() > 0) {
		List<Candidate__c> lstCandidate = [SELECT Id, Email__c, OwnerID  FROM Candidate__c WHERE Id IN :candidates];
		EmailManager.sendConfirmEmails(lstCandidate);
	}
	
}