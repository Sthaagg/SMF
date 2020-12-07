Scriptname _SMF_WaterUtils hidden
{Water Detection function}

import _SMF_Utils
import PO3_SKSEFunctions

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

bool function IsInWater(Actor akActor) global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    ;Test if actor is in water
    bool result = false
    If !IsActorUnderwater(akActor) && IsActorInWater(akActor)
        result = true
    EndIf
    If result
        SMFDebugInfo("In Water")
    EndIf
    return result
endFunction