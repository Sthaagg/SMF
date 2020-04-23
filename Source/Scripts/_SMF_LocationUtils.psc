Scriptname _SMF_LocationUtils  Hidden 

import _SMF_Utils

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

Bool Function IsInDangerousPlace() global
    If IsInSupernaturalAndultraUnhealthyPlace() || IsInAbandonnedAndVeryUnhealthyPlace() || IsInCampAndHighUnhealthyPlace() || IsInCampAndAverageUnhealthyPlace() || IsInDwemerAndLowUnhealthyPlace() || IsInCaveAndLowUnhealthyPlace() || IsInSupernaturalAndHighHealthyPlace()
        return true
    Else
        return false
    Endif
EndFunction

Bool Function IsinSafePlace() global
    If IsInLowPopulatedAndLowHealthyPlace() || IsInPopulatedSafeAndAverageHealthyPlace() || IsInSafeAndUltraHealthyPlace()
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
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_SupernaturalAndultraUnhealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInAbandonnedAndVeryUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_AbandonnedAndVeryUnhealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInCampAndHighUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_CampAndHighUnhealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInCampAndAverageUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_CampAndAverageUnhealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInDwemerAndLowUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_DwemerAndLowUnhealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInCaveAndLowUnhealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_CaveAndLowUnhealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInLowPopulatedAndLowHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_LowPopulatedAndLowHealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInPopulatedSafeAndAverageHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_PopulatedSafeAndAverageHealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInSupernaturalAndHighHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_SupernaturalAndHighHealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInPopulatedAndHighHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_PopulatedAndHighHealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction

Bool Function IsInSafeAndUltraHealthyPlace() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
    endif
    return false
    Location CurrentPlayerLocation = SMF.PlayerRef.GetCurrentLocation()
    Formlist KeywordList = SMF._SMF_SafeAndUltraHealthyPlace

    Int idx = KeywordList.GetSize()
    While idx > 0
        Keyword Test = KeywordList.GetAt(idx) as Keyword
        If CurrentPlayerLocation.HasKeyword(Test)
            return true
        EndIf
        idx -= 1
    EndWhile
EndFunction