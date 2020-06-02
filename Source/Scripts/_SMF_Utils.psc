Scriptname _SMF_Utils  Hidden 

_SMF_API function GetAPI() global
	return (Game.GetFormFromFile(0xD61, "SMF.esl") as Quest) as _SMF_API
endFunction

Function SMFDebugInfo(String akText,Int aiMode = 1 ) global; aiMode 1 = notification (default mode), aiMode 2 = Trace
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return none
    endif
    If SMF.GeneralDebug 
        If aiMode == 1
            Debug.notification("[SMF] " + akText)
        ElseIf aiMode == 2
            Debug.trace("[SMF] " + akText)
        Endif
    EndIf
EndFunction

Function Closemenu() global
;Convenient function, Close menu properly
    Game.DisablePlayerControls(False, False, False, False, False, True)	; Close menu
    Utility.Wait(0.01)
    Game.EnablePlayerControls(False, False, False, False, False, True)	; Reenable menu	to let player open it again ;)
EndFunction

function ClosemenuAlt(string menu) global
	Int TweenKey = Input.GetMappedKey("Tween Menu")
    While !UI.IsMenuOpen(menu)
		Input.TapKey(TweenKey)
		utility.wait(0.1)
    Endwhile
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
	Int i = 10
	While i > 0
		i -= 1
		kPlayerDialogueTarget = Game.FindRandomActorFromRef(SMF.PlayerREF , 200.0)
		If kPlayerDialogueTarget != SMF.PlayerREF && kPlayerDialogueTarget.IsinDialogueWithPlayer() 
			Return kPlayerDialogueTarget
		EndIf
	EndWhile
        Return None
EndFunction

float[] function GetOffsets(Actor akSource, Float afDistance = 100.0, float afOffset = 0.0) global
    Float A = akSource.GetAngleZ() + afOffset
    Float YDist = Math.Sin(A)
    Float XDist = Math.Cos(A)

    XDist *= afDistance
    YDist *= afDistance

    Float[] Offsets = New Float[2]
    Offsets[0] = YDist
    Offsets[1] = XDist
    Return Offsets
EndFunction

float[] Function GetActorPosition(Actor akSource) global
	float X = akSource.GetPositionX() as Float
	float Y = akSource.GetPositionY() as Float
	Float Z = akSource.GetPositionZ() as Float

	Float[] Coordinates = New Float[3]
	Coordinates[0] = X
	Coordinates[1] = Y
	Coordinates[2] = Z
	return Coordinates
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
				SMFDebugInfo("akActor distance: " + SMF.PlayerREF.GetDistance(akActor),2)
                return true
			endif
		endif
	else
		SMFDebugInfo("akActor distance: " + SMF.PlayerREF.GetDistance(akActor),2)
		return true
	endif
endFunction

Bool Function IsSitting(Actor akActor) global
;Test if game considers that actor is sitting then check if he uses an appropriate furniture as game make no difference between leaning against a pole or sitting
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

ObjectReference[] function ListObjectRefInCell(Int aiFormtype, ObjectReference akObject = None, Cell acCell = none) global
	Cell kCell = acCell
	If akObject
	kCell = AkObject.GetParentCell()
	EndIf
Int iIndex = kCell.GetNumRefs(aiFormtype)
ObjectReference[] objectReferencesList = new ObjectReference[100]
while (iIndex)
    iIndex -= 1
    objectReferencesList[iIndex] = kCell.GetNthRef(iIndex, aiFormtype)
endwhile
	return objectReferencesList
EndFunction