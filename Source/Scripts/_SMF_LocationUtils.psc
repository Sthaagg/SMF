Scriptname _SMF_LocationUtils  Hidden 

import _SMF_Utils
import _SMF_ArrayUtils

Bool Function IsunderShelter() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    If SMF.bIsUnderShelter
        return true
    EndIf
    return false 
EndFunction

Bool Function IsunderTent() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    If SMF.bIsUnderCampfireTent
        return true
    EndIf
    return false 
EndFunction

Int Function GetPlayerlocationType() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    If IsInSupernaturalAndultraUnhealthyPlace()
        return 1
    ElseIf IsInAbandonnedAndVeryUnhealthyPlace()
        return 2
    ElseIf IsInCampAndHighUnhealthyPlace()
        return 3
    ElseIf IsInCampAndAverageUnhealthyPlace()
        return 4
    ElseIf IsInDwemerAndLowUnhealthyPlace()
        return 5
    ElseIf IsInCaveAndLowUnhealthyPlace()
        return 6
    ElseIf IsInLowPopulatedAndLowHealthyPlace()
        return 7
    ElseIf IsInPopulatedSafeAndAverageHealthyPlace()
        return 8
    ElseIf IsInSupernaturalAndHighHealthyPlace()
        return 9
    ElseIf IsInPopulatedAndHighHealthyPlace()
        return 10
    ElseIf IsInSafeAndUltraHealthyPlace()
        return 11
    Else
        return 100 ;unknown location
    Endif
EndFunction
;location classified by type

Bool Function IsInDangerousPlace() global
    If IsInSupernaturalAndultraUnhealthyPlace() || IsInAbandonnedAndVeryUnhealthyPlace() || IsInCampAndHighUnhealthyPlace() || IsInCampAndAverageUnhealthyPlace() || IsInDwemerAndLowUnhealthyPlace() || IsInCaveAndLowUnhealthyPlace() || IsInSupernaturalAndHighHealthyPlace()
        return true
    Else
        return false
    Endif
EndFunction

Bool Function IsinSafePlace() global
    If IsInLowPopulatedAndLowHealthyPlace() || IsInPopulatedSafeAndAverageHealthyPlace() || IsInSafeAndUltraHealthyPlace() || IsInPopulatedAndHighHealthyPlace()
        return true
    Else
        return false
    Endif
EndFunction

Bool Function IsInUnhealthyArea() global
    If IsinSupernaturalAndultraUnhealthyPlace() || IsInAbandonnedAndVeryUnhealthyPlace() || IsInCampAndHighUnhealthyPlace() || IsInCampAndAverageUnhealthyPlace()
        return true
    Else
        return false
    EndIf
EndFunction

Bool Function IsInHealthyArea()
    If IsInLowPopulatedAndLowHealthyPlace() || IsInPopulatedSafeAndAverageHealthyPlace() || IsInSupernaturalAndHighHealthyPlace() || IsInPopulatedAndHighHealthyPlace() || IsInSafeAndUltraHealthyPlace()
        return true
    Else
        return false
    EndIf
EndFunction

Bool Function IsInSupernaturalAndultraUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iSupernaturalAndultraUnhealthyPlaceArray)
    SMFDebugInfo("Liste 1, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.SupernaturalAndultraUnhealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInAbandonnedAndVeryUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iAbandonnedAndVeryUnhealthyPlaceArray)
    SMFDebugInfo("Liste 2, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.AbandonnedAndVeryUnhealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInCampAndHighUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iCampAndHighUnhealthyPlaceArray)
    SMFDebugInfo("Liste 3, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.CampAndHighUnhealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInCampAndAverageUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iCampAndAverageUnhealthyPlaceArray)
    SMFDebugInfo("Liste 4, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.CampAndAverageUnhealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInDwemerAndLowUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iDwemerAndLowUnhealthyPlaceArray)
    SMFDebugInfo("Liste 5, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.DwemerAndLowUnhealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction


Bool Function IsInCaveAndLowUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iCaveAndLowUnhealthyPlaceArray)
    SMFDebugInfo("Liste 6, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.CaveAndLowUnhealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInLowPopulatedAndLowHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iLowPopulatedAndLowHealthyPlaceArray)
    SMFDebugInfo("Liste 7, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.LowPopulatedAndLowHealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInPopulatedSafeAndAverageHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iPopulatedSafeAndAverageHealthyArray)
    SMFDebugInfo("Liste 8, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.PopulatedSafeAndAverageHealthyArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInSupernaturalAndHighHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iSupernaturalAndHighHealthyArray)
    SMFDebugInfo("Liste 9, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.SupernaturalAndHighHealthyArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInPopulatedAndHighHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iPopulatedAndHighHealthyPlaceArray)
    SMFDebugInfo("Liste 10, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.PopulatedAndHighHealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsInSafeAndUltraHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
        Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    If !CurrentPlayerLocation
        return false
    EndIf
    Int idx = (SMF.iSafeAndUltraHealthyPlaceArray)
    SMFDebugInfo("Liste 11, Keyword count:" + idx,2)
    While idx > 0
        Keyword Test = SMF.SafeAndUltraHealthyPlaceArray[idx - 1]
        SMFDebugInfo("Tested keyword: " + Test,2)
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
    return false
EndFunction

Bool Function IsPleasant() global
    If Weather.GetCurrentWeather().GetClassification() == 0
        return true
    EndIf
    return false
EndFunction

Bool Function IsCloudy() global
    If Weather.GetCurrentWeather().GetClassification() == 1
        return true
    EndIf
    return false
EndFunction

Bool Function IsRaining() global
    If Weather.GetCurrentWeather().GetClassification() == 2
        return true
    EndIf
    return false
EndFunction

Bool Function IsSnowing() global
    If Weather.GetCurrentWeather().GetClassification() == 3
        return true
    EndIf
    return false
EndFunction

