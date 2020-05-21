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
		SMFDebugInfo("Loaded: " + akPluginName,2)
		return true
	else
		return false
	endif
endFunction

function Moddetection()
    SMFDebugInfo(";=============== Compatibility Check Process Start ======================;",2)
    SMFDebugInfo(";=============== Mod Detection Begin ====================================;",2)
    SMFDebugInfo(";=============== The following errors are normal ========================;",2)
    if SMF.bIsFrostfallisLoaded
        SMF.bIsFrostfallisLoaded = IsPluginLoaded(0x00064590, "Frostfall.esp")
        SMF.bIsCampingIsLoaded = true
        if !SMF.bIsFrostfallisLoaded
            SMFDebugInfo("Frostfall was removed since the last save.",2)
        endif
    else
        SMF.bIsFrostfallisLoaded = IsPluginLoaded(0x00064590, "Frostfall.esp")
        if SMF.bIsFrostfallisLoaded
            SMF.bIsCampingIsLoaded = true
            SMFDebugInfo("Frostfall was just added.",2)
        endif
    endif
    if !SMF.bIsFrostfallisLoaded
        If SMF.bIsCampingIsLoaded
            SMF.bIsCampingIsLoaded = IsPluginLoaded(0x00022033, "Campfire.esm")
            if !SMF.bIsCampingIsLoaded
                SMFDebugInfo("Campfire was removed since the last save.",2)
            endif
            else
            SMF.bIsCampingIsLoaded = IsPluginLoaded(0x00022033, "Campfire.esm")
            if SMF.bIsCampingIsLoaded
                SMFDebugInfo("Campfire was just added.",2)
            endif
        EndIf
    Else
        SMFDebugInfo("Frostfall used, Campfire compatibility added by default",2)
    endif  
    SMFDebugInfo(";=============== Mod Detection End ======================================;",2)
    SMFDebugInfo(";=============== Compatibility Check Process End ========================;",2)
EndFunction