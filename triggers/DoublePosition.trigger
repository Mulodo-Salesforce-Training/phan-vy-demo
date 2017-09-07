trigger DoublePosition on Position__c (before insert, before update) {
	if (trigger.isInsert) {
		for(Position__c pos: Trigger.New) {

			Position__c[] comparePos = [SELECT Name FROM Position__c WHERE Name = :pos.Name LIMIT 1];
			if (comparePos.size() > 0) {
					pos.addError('Position Name must be unique');
			}
		}
	} else if (trigger.isUpdate) {
		for(Position__c pos: trigger.New) {
			Position__c oldPos = trigger.oldMap.get(pos.id);
			if (oldPos.Name != pos.Name) {
		
				Position__c[] comparePos = [SELECT Name FROM Position__c WHERE Name = :pos.Name LIMIT 1];
				if (comparePos.size() > 0) {
					pos.addError('Position Name must be unique');
				}
			}
		}
	}	
}