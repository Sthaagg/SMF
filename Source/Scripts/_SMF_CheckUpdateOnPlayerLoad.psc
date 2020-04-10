Scriptname _SMF_CheckUpdateOnPlayerLoad extends ReferenceAlias Hidden 
;===============  PROPERTIES  ==========================================;
_SMF_SelfUpdate Property QuestScript Auto
;===============    EVENTS    ==========================================;
Event OnPlayerLoadGame()
	QuestScript.Maintenance()
EndEvent