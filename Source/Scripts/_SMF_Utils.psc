Scriptname _SMF_Utils  Hidden 

_SMF_API function GetAPI() global
	return (Game.GetFormFromFile(0xD61, "SMF.esl") as Quest) as _SMF_API
endFunction

Function Closemenu() global
;Convenient function, Close menu properly
    Game.DisablePlayerControls(False, False, False, False, False, True)	; Close menu
    Utility.Wait(0.01)
    Game.EnablePlayerControls(False, False, False, False, False, True)	; Reenable menu	to let player open it again ;)
EndFunction

Actor Function GetPlayerDialogueTarget() global
;Detecty which actor is currently talking to the player.
;Return Actor Ref
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
	Actor kPlayerDialogueTarget
	Int iLoopCount = 10
	While iLoopCount > 0
		iLoopCount -= 1
		kPlayerDialogueTarget = Game.FindRandomActorFromRef(SMF.PlayerREF , 200.0)
		If kPlayerDialogueTarget != SMF.PlayerREF && kPlayerDialogueTarget.IsinDialogueWithPlayer() 
			Return kPlayerDialogueTarget
		EndIf
	EndWhile
        Return None
EndFunction

Float Function GetPlayerPosition(String sAxe) global
;Convenient function, Return float with axis position for player
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
	endif
	Float Coordinate
	if sAxe == "X"
		Coordinate = SMF.PlayerRef.GetPositionX() as Float
		return Coordinate
	ElseIf 	sAxe == "Y"
		Coordinate = SMF.PlayerRef.GetPositionY() as Float
	ElseIf 	sAxe == "Z"
		Coordinate = SMF.PlayerRef.GetPositionZ() as Float
	EndIf
	return Coordinate
EndFunction

bool Function ActorIsNearPlayer(Actor akActor) global
;Detect if actor is in same cell as the playern and distance is inferior to 512 units
;Return true
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
	endif
    Cell targetCell = akActor.GetParentCell()
	Cell playerCell = SMF.PlayerREF.GetParentCell()
	if (targetCell != playerCell)
		if (targetCell && targetCell.IsInterior() || playerCell && playerCell.IsInterior())
			return false
		else
			if (SMF.PlayerREF.GetDistance(akActor) > 512)
				return false
			else
				If SMF.GeneralDebug
					Debug.Notification("akActor distance: " + SMF.PlayerREF.GetDistance(akActor))
				EndIf
                return true
			endif
		endif
	else
		If SMF.GeneralDebug
			Debug.Notification("akActor distance: " + SMF.PlayerREF.GetDistance(akActor))
		EndIf
		return true
	endif
endFunction

Bool Function IsSitting(Actor akActor) global
;Test if game considers that actor is sitting then check if he uses an appropriate furniture as game make no difference btween leaning against a pole or sitting
;Return true if ok, must be used in a variable
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
	endif
	If (akActor.GetSitState() != 0)
    	objectreference Furnitureref = game.FindClosestReferenceOfAnyTypeInListFromRef(SMF._SMF_FurnitureSit,akActor,64)
    	if Furnitureref
        	return true
    	Else
        	return false
		EndIf
	EndIf
	return false
EndFunction

function RaiseSMFAPIError() global
	debug.trace("[SMF][ERROR] Fatal SMF API error occurred.")
endFunction

