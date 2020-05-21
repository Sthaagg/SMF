Scriptname _SMF_WaterUtils hidden
{Water Detection function}

import _SMF_Utils

bool function IsCloseToWater(Actor akActor) global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    ;Test if the actor near water
    float waterlevel = akActor.GetParentCell().GetWaterLevel()
    bool isunderwaterlevel = akActor.GetPositionZ() < waterlevel || waterlevel == 0.0
    ; Test if actor is standing in water (and not swimming)
    if (!akActor.IsSwimming() && (akActor.IsInInterior() || isunderwaterlevel) ); && IsInWater(akActor))
        SMFDebugInfo("WaterClose")
        return true
    endIf
    return false
endFunction

bool function IsCloseToWaterfall(Actor akActor) global;; Water falldetection is not very accurate due to game limitation
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    ; Test if actor is near watterfall
    Bool Found
    
    Int i3 = SMF.iWfallAmbArray
    While i3 > 0
        i3 -= 1
        ObjectReference ClosestWFallAmb = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallAmbArray[i3] as form, akActor, 200.0)
        If ClosestWFallAmb
            i3 = 0
            SMFDebugInfo("Wfall Ambient:" + ClosestWFallAmb,2)
            return true
        EndIf
    EndWhile
    If SMF.GeneralDebug
        debug.Notification("No Wfall detected")
    EndIf

    Int i2 = SMF.iWfallBtomArray
    While i2 > 0
        i2 -= 1
        ObjectReference ClosestWFallBtom = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallBtomArray[i2] as form, akActor, 200.0)
        If ClosestWFallBtom
            i2 = 0
            SMFDebugInfo("Wfall Bottom:" + ClosestWFallBtom,2)
            return true
        EndIf
    EndWhile

    Int i = SMF.iWfallTopArray
    While i > 0
        i -= 1
        ObjectReference ClosestWFallTop = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallTopArray[i] as form, akActor, 200.0)
        If ClosestWFallTop
            i = 0
            SMFDebugInfo("Wfall Top:" + ClosestWFallTop,2)
            return true
        EndIf
    EndWhile
    
    return false
endFunction

bool function IsInWater(Actor akActor, bool fastcheck = false) global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    ;Test if actor is in water
    bool result = false
    float afOffset
    if !fastcheck
        Game.DisablePlayerControls(True, True, True, False, True, False, True) ; Disable all controls except looking.
        afOffset = 180
    Else
        afOffset = 0
    EndIf
    ; We spawn a fish and test if he can swim
    ObjectReference Marker = akActor.PlaceAtMe(SMF.Xmarker, 1, true, false)
    float[] heading_pos = GetOffsets(akActor, 60, afOffset)
    Marker.MoveTo(akActor, heading_pos[0], heading_pos[1])
    Actor Test = Marker.PlaceAtMe(SMF.WaterTestActor, 1, true, false) as Actor
    Test.SetAlpha(0.0)
    Test.SetAngle(0.0, 0.0, 0.0)
    result = (Test as Actor).IsSwimming() 
    Test.DisableNoWait()
    Test.Delete()
    Marker.DisableNoWait()
    Marker.Delete()
    if !fastcheck
        Game.EnablePlayerControls() ; Enable all controls
    EndIf

    If result
        SMFDebugInfo("In Water")
    EndIf
    return result
endFunction