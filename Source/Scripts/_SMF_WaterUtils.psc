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
    float WaterLevel = akActor.GetParentCell().GetWaterLevel()
    bool IsUnderWaterLevel = akActor.GetPositionZ() < waterLevel || waterLevel == 0.0
    ; Test if actor is standing in water (and not swimming)
    if (!akActor.IsSwimming() && (akActor.IsInInterior() || IsUnderWaterLevel) ); && IsInWater(akActor))
        If SMF.GeneralDebug
            debug.Notification("WaterClose")
        EndIf
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
    
    Int I3 = SMF.iWfallAmbArray
    While I3 > 0
        ObjectReference ClosestWFallAmb = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallAmbArray[I3] as form, akActor, 200.0)
        If ClosestWFallAmb
            I3 = 0
            If SMF.GeneralDebug
                debug.Notification("Wfall Ambient:" + ClosestWFallAmb)
            EndIf
            return true
        Else
            I3 -= 1
        EndIf
    EndWhile
    If SMF.GeneralDebug
        debug.Notification("No Wfall detected")
    EndIf

    Int I2 = SMF.iWfallBtomArray
    While I2 > 0
        ObjectReference ClosestWFallBtom = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallBtomArray[I2] as form, akActor, 200.0)
        If ClosestWFallBtom
            I2 = 0
            If SMF.GeneralDebug
                debug.Notification("Wfall Bottom:" + ClosestWFallBtom)
            EndIf
            return true
        Else
            I2 -= 1
        EndIf
    EndWhile

    Int I = SMF.iWfallTopArray
    While I > 0
        ObjectReference ClosestWFallTop = Game.FindClosestReferenceOfTypeFromRef(SMF._SMF_WFallTopArray[I] as form, akActor, 200.0)
        If ClosestWFallTop
            I = 0
            If SMF.GeneralDebug
                debug.Notification("Wfall Top:" + ClosestWFallTop)
            EndIf
            return true
        Else
            I -= 1
        EndIf
    EndWhile
    
    return false
endFunction

bool function IsInWater(Actor akActor) global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    ;Test if actor is in water
    bool Result = false

    Game.DisablePlayerControls(True, True, True, False, True, False, True) ; Disable all controls except looking.
        
    ; We spawn a fish and test if he can swim
    Actor Test = akActor.PlaceAtMe(SMF.WaterTestActor, 1, true, false) as Actor
    Test.SetAlpha(0.0)
    Test.MoveTo(akActor, 30.0 * Math.Sin(akActor.GetAngleZ()), 30.0 * Math.Cos(akActor.GetAngleZ()), 2.0)
    Test.SetAngle(0.0, 0.0, 0.0)
    Result = (Test as Actor).IsSwimming() 
    Test.Disable()
    Test.Delete()
    
    Game.EnablePlayerControls() ; Enable all controls
    If result && SMF.GeneralDebug
        debug.Notification("In Water")
    EndIf
    return Result
endFunction