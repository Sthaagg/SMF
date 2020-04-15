Scriptname _SMF_TimeUtils Hidden

import _SMF_Utils
Import Utility
Import Math

float function GetTimeStamp(int Unit) global
;/  
+   If unit 1 Result is returned in Hour, 2 in Day
+   Result is returned as a float so it needs to be called in a variable 
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    float result
    If Unit == 1
        result = GetCurrentGameTimeInHour()
    Elseif unit == 2
        result = GetCurrentGameTime()
    Endif
    DebugInfo("TimeStamp: " + result,2)
    return result
EndFunction

float function CalculTimePassed(Float PreviousTime, int Unit) global
;/  
+   Mode 1 Result is returned in Hour, 2 in Day
+   You must use same unit as the one used with GameTimeStamp() or from the variable you use
+   Result is returned as a float so it needs to be called in a variable 
/;
_SMF_API SMF = GetAPI()
if SMF == none
    RaiseSMFAPIError()
    return 0
endif
    Float currenttime
    If Unit == 1
        currenttime = GetCurrentGameTimeInHour()
    Elseif Unit == 2
        currenttime = GetCurrentGameTime()
    Endif
    Float difference = currenttime - PreviousTime
If SMF.GeneralDebug
    If unit == 1
        Int H = difference as Int
        Float min = ((difference - h) * 60) 
        float Secs = ((min - min as Int) * 60) 
        Debug.Notification("CountTimeSpent: " + H + ":" + (min as Int) + ":" + (Secs as Int))
    Else
        Int D = difference as Int
        Float H = difference - D * 24
        Float min = ((D - H) * 60) 
        Float Secs = ((min - min as Int) * 60) 
        Debug.Notification("CountTimeSpent: " + D + ":" + (H as Int)+ ":" + (Min as Int) + ":" + (Secs as Int))
    EndIf
EndIf
return difference
EndFunction

Int Function CountTotalDaysSpent() Global 
;/  
+   Returns the number of fully passed ingame days
+   Result is returned as a Int so it needs to be called in a variable
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    Float GameDaysPassed
 
	GameDaysPassed = GetCurrentGameTime()
    DebugInfo("CountTotalDaysSpent: " + GameDaysPassed As Int)
    Return GameDaysPassed As Int
EndFunction

Int Function CountTotalhourSpent() global 
;/  
+   returns the number of fully passed hour ingame
+   Result is returned as a Int so it needs to be called in a variable
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    float GameHourPassed = GetCurrentGameTime()
	GameHourPassed *= 24 ; Convert day to number of hours
    DebugInfo("CountTotalhourSpent: "+  GameHourPassed as Int)
    Return GameHourPassed as Int
EndFunction

Float Function GetCurrentGameTimeInHour() global
;/  
+   returns the number of passed hour ingame
+   Result is returned as a Float so it needs to be called in a variable
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    float GameHourPassed = GetCurrentGameTime()
	GameHourPassed *= 24 ; Convert day to number of hours
    DebugInfo("CountTotalhourSpent: "+ GameHourPassed + "H")
    Return GameHourPassed
EndFunction


Int Function GetCurrentDayHour() global
;/  
+   returns what hour it is. (like 12)
+   Result is returned as a Int so it needs to be called in a variable
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    float Time = GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
    DebugInfo("GetCurrentDayHour: It is "+ Time as Int +" o'clock")
    Return Time as Int
EndFunction

; Credit Creation Kit Wiki for the script belows:
;/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+	GetCurrentMoonPhase() returns an integer representing the current
+	phase of the moons Masser and Secunda based on "SkyrimClimate".
+	Between 12:00 AM and 11:59 AM the phase during the night from last
+	day to this day is returned. Between 12:00 PM and 11:59 PM the
+	phase for the night from this day to next day is returned. Thus
+	a call to the function at night (between 8:00 PM and 6:00 AM) all-
+	ways returns the currently visible phase.
+
+	The returncodes are as follows:
+		0 - Full Moon
+		1 - Decreasing Moon 3/4
+		2 - Decreasing Moon 1/2
+		3 - Decreasing Moon 1/4
+		4 - New Moon
+		5 - Increasing Moon 1/4
+		6 - Increasing Moon 1/2
+		7 - Increasing Moon 3/4
+
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/;

Int Function GetCurrentMoonphase() Global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    Int GameDaysPassed
	Int GameHoursPassed
    Int PhaseTest
    Int result
	GameDaysPassed = CountTotalDaysSpent()
	GameHoursPassed = GetCurrentDayHour()
 
	If (GameHoursPassed >= 12.0)
		GameDaysPassed += 1
	EndIf
 
	PhaseTest = GameDaysPassed % 24 ;A full cycle through the moon phases lasts 24 days
    If PhaseTest >= 22 || PhaseTest == 0
        Result = 7
	ElseIf PhaseTest < 4
		Result = 0
	ElseIf PhaseTest < 7
		Result = 1
	ElseIf PhaseTest < 10
		Result = 2
	ElseIF PhaseTest < 13
		Result = 3
	ElseIf PhaseTest < 16
		Result = 4
	ElseIf PhaseTest < 19
		Result = 5
	ElseIf PhaseTest < 22
		Result = 6
	EndIf
    DebugInfo("GetCurrentMoonphase Result:" + result)
    return result
EndFunction

;/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+	GetCurrentMoonSync() returns an integer that resembles where we are
+	in the 5 day cycle of the Snychronisation between the moons.
+
+   Returncodes:
+		0 - Moons appear at the same time
+		1 - not yet determined how far ahead/behind Secunda is
+		2 - not yet determined how far ahead/behind Secunda is
+		3 - not yet determined how far ahead/behind Secunda is
+		4 - not yet determined how far ahead/behind Secunda is
+
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/;

Int Function GetCurrentMoonSync() Global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    Int GameDaysPassed
	Int GameHoursPassed
	Int SyncTest
 
	GameDaysPassed = CountTotalDaysSpent()
	GameHoursPassed = GetCurrentDayHour()
	If (GameHoursPassed >= 12)
		GameDaysPassed += 1
	EndIf
	SyncTest = GameDaysPassed % 5
    DebugInfo("GetCurrentMoonSync" + SyncTest)
    return SyncTest
EndFunction

;/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+	GetDayOfWeek() returns the current ingame day of the week as int.
+	
+	Returncodes:
+		0 - Sundas
+		1 - Morndas
+		2 - Tirdas
+		3 - Middas
+		4 - Turdas
+		5 - Fredas
+		6 - Loredas
+
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/;
 
Int Function GetDayOfWeek() Global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    Int GameDaysPassed
 
	GameDaysPassed = CountTotalDaysSpent()
    DebugInfo("GetDayOfWeek" + GameDaysPassed % 7)
    return GameDaysPassed % 7
EndFunction