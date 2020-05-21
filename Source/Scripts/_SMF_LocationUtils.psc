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
    Int idx = ArrayTotalCountKeyword(SMF.SupernaturalAndultraUnhealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.SupernaturalAndultraUnhealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.AbandonnedAndVeryUnhealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.AbandonnedAndVeryUnhealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.CampAndHighUnhealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.CampAndHighUnhealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.CampAndAverageUnhealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.CampAndAverageUnhealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.DwemerAndLowUnhealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.DwemerAndLowUnhealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.CaveAndLowUnhealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.CaveAndLowUnhealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.LowPopulatedAndLowHealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.LowPopulatedAndLowHealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.PopulatedSafeAndAverageHealthyArray)

    While idx > 0
        Keyword Test = SMF.PopulatedSafeAndAverageHealthyArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.SupernaturalAndHighHealthyArray)

    While idx > 0
        Keyword Test = SMF.SupernaturalAndHighHealthyArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.PopulatedAndHighHealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.PopulatedAndHighHealthyPlaceArray[idx]
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
    Int idx = ArrayTotalCountKeyword(SMF.SafeAndUltraHealthyPlaceArray)

    While idx > 0
        Keyword Test = SMF.SafeAndUltraHealthyPlaceArray[idx]
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

