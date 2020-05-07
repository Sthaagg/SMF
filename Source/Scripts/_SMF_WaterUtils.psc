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
        ObjectReference ClosestWFallAmb = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallAmbArray[i3] as form, akActor, 200.0)
        If ClosestWFallAmb
            i3 = 0
            SMFDebugInfo("Wfall Ambient:" + ClosestWFallAmb,2)
            return true
        Else
            i3 -= 1
        EndIf
    EndWhile
    If SMF.GeneralDebug
        debug.Notification("No Wfall detected")
    EndIf

    Int i2 = SMF.iWfallBtomArray
    While i2 > 0
        ObjectReference ClosestWFallBtom = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallBtomArray[i2] as form, akActor, 200.0)
        If ClosestWFallBtom
            i2 = 0
            SMFDebugInfo("Wfall Bottom:" + ClosestWFallBtom,2)
            return true
        Else
            i2 -= 1
        EndIf
    EndWhile

    Int i = SMF.iWfallTopArray
    While i > 0
        ObjectReference ClosestWFallTop = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallTopArray[i] as form, akActor, 200.0)
        If ClosestWFallTop
            i = 0
            SMFDebugInfo("Wfall Top:" + ClosestWFallTop,2)
            return true
        Else
            i -= 1
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
    if !fastcheck
        Game.DisablePlayerControls(True, True, True, False, True, False, True) ; Disable all controls except looking.
    EndIf
    ; We spawn a fish and test if he can swim
    Actor Test = akActor.PlaceAtMe(SMF.WaterTestActor, 1, true, false) as Actor
    Test.SetAlpha(0.0)
    Test.MoveTo(akActor, 30.0 * Math.Sin(akActor.GetAngleZ()), 30.0 * Math.Cos(akActor.GetAngleZ()), 2.0)
    Test.SetAngle(0.0, 0.0, 0.0)
    result = (Test as Actor).IsSwimming() 
    Test.DisableNoWait()
    Test.Delete()

    if !fastcheck
        Game.EnablePlayerControls() ; Enable all controls
    EndIf

    If result
        SMFDebugInfo("In Water")
    EndIf
    return result
endFunction