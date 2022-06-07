Scriptname _SMF_TeamCheck extends Quest  
;===============  PROPERTIES  ==========================================;
_SMF_API property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_TeamUtils
;===============    EVENTS    ==========================================;
event OnInit()
    AutoDetectTeam(SMF._SMFTeamExcludedAliases)
endevent