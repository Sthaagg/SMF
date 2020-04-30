Scriptname _SMF_Compatibility extends Quest Hidden 
;===============  PROPERTIES  ==========================================;
_SMF_API property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
;===============  VARIABLES   ==========================================;
;===============  EVENTS      ==========================================;
;===============  FUNCTIONS   ==========================================;
bool function IsPluginLoaded(int aiFormID, string akPluginName)
	bool b = Game.GetFormFromFile(aiFormID, akPluginName)
	if b
		DebugInfo("Loaded: " + akPluginName,2)
		return true
	else
		return false
	endif
endFunction

function Moddetection()
    DebugInfo(";=============== Compatibility Check Process Start ======================;",2)
    DebugInfo(";=============== Mod Detection Begin ====================================;",2)
    DebugInfo(";=============== The following errors are normal ========================;",2)
    if SMF.bIsFrostfallisLoaded
        SMF.bIsFrostfallisLoaded = IsPluginLoaded(0x00064590, "Frostfall.esp")
        if !SMF.bIsFrostfallisLoaded
            ;Frostfall was removed since the last save.
        endif
    else
        SMF.bIsFrostfallisLoaded = IsPluginLoaded(0x00064590, "Frostfall.esp")
        if SMF.bIsFrostfallisLoaded
            ;Frostfall was just added.
        endif
    endif
    DebugInfo(";=============== Mod Detection End ======================================;",2)
    DebugInfo(";=============== Compatibility Check Process End ========================;",2)
EndFunction