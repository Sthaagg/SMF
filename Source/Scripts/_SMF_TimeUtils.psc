Scriptname _SMF_TimeUtils Hidden

import _SMF_Utils
Import Utility
Import Math

float function GetTimeStamp(int aiUnit) global
;/  
+   If aiUnit 1 Result is returned in Hour, 2 in Day
+   Result is returned as a float so it needs to be called in a variable 
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return 0
    endif
    float result
    If aiUnit == 1
        result = GetCurrentGameTimeInHour()
    Elseif aiUnit == 2
        result = GetCurrentGameTime()
    Endif
    return result
EndFunction

float function CalculTimePassed(Float afPreviousTime, int aiUnit) global
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
    If aiUnit == 1
        currenttime = GetCurrentGameTimeInHour()
    Elseif aiUnit == 2
        currenttime = GetCurrentGameTime()
    Endif
    Float difference = currenttime - afPreviousTime
If SMF.GeneralDebug
    If aiUnit == 1
        Int H = difference as Int
        Float min = ((difference - h) * 60) 
        float Secs = ((min - min as Int) * 60) 
    Else
        Int D = difference as Int
        Float H = difference - D * 24
        Float min = ((D - H) * 60) 
        Float Secs = ((min - min as Int) * 60) 
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
    Float gamedayspassed
 
	gamedayspassed = GetCurrentGameTime()
    Return gamedayspassed As Int
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
    float gamehourspassed = GetCurrentGameTime()
	gamehourspassed *= 24 ; Convert day to number of hours
    Return gamehourspassed as Int
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
    float gamehourspassed = GetCurrentGameTime()
	gamehourspassed *= 24 ; Convert day to number of hours
    Return gamehourspassed
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
    float time = GetCurrentGameTime()
	time -= Math.Floor(time) ; Remove "previous in-game days passed" bit
	time *= 24 ; Convert from fraction of a day to number of hours
    Return time as Int
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
    Int gamedayspassed
	Int gamehourspassed
    Int phasetest
    Int result
	gamedayspassed = CountTotalDaysSpent()
	gamehourspassed = GetCurrentDayHour()
 
	If (gamehourspassed >= 12.0)
		gamedayspassed += 1
	EndIf
 
	phasetest = gamedayspassed % 24 ;A full cycle through the moon phases lasts 24 days
    If phasetest >= 22 || phasetest == 0
        Result = 7
	ElseIf phasetest < 4
		Result = 0
	ElseIf phasetest < 7
		Result = 1
	ElseIf phasetest < 10
		Result = 2
	ElseIF phasetest < 13
		Result = 3
	ElseIf phasetest < 16
		Result = 4
	ElseIf phasetest < 19
		Result = 5
	ElseIf phasetest < 22
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
    Int gamedayspassed
	Int gamehourspassed
	Int synctest
 
	gamedayspassed = CountTotalDaysSpent()
	gamehourspassed = GetCurrentDayHour()
	If (gamehourspassed >= 12)
		gamedayspassed += 1
	EndIf
	synctest = gamedayspassed % 5
    DebugInfo("GetCurrentMoonSync" + synctest)
    return synctest
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
    Int gamedayspassed
 
	gamedayspassed = CountTotalDaysSpent()
    DebugInfo("GetDayOfWeek" + gamedayspassed % 7)
    return gamedayspassed % 7
EndFunction