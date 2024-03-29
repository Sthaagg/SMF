Scriptname _SMF_TeamUtils  Hidden 
{_SMF_AutoDetectTeam quest must be started if you want to use AutoDetectTeam() function}
;/ You need to create two array ex:
Form[] Property _SMF_ActorArray Auto Hidden; Empty, Store manual added
Form[] Property _SMF_ExlusionList Auto Hidden; Empty, Store NPCs which must be ignored
/;
import _SMF_Utils
import _SMF_ArrayUtils

Function AutoDetectTeam(form[] akExlusionList) global
    ;/  useful function for mod which manage follower and teammate, it is what I use in Better Facelight or Keep It Clean
        This function get the alias from dedicated quest and store them in an Array, this one is hardcoded so it can be shared by any mod which use this function
        due to how follower/temamate are detected it will be a waste of ressource to use different array.
        Nothing to do except starting the dedicated quest _SMF_AutoDetectTeam
    /;
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif  
    int idx  = (SMF._SMF_AutoDetectTeam.GetNumAliases())
    SMFDebugInfo("idx = "+ idx); for testing purpose
	While idx > 0
		ReferenceAlias nthAlias = SMF._SMF_AutoDetectTeam.GetNthAlias(idx - 1) as ReferenceAlias
        If nthAlias
			Actor teammate = nthAlias.GetActorReference()
            AddActortoTeamList(teammate,SMF._SMFAutoTeamAliases,akExlusionList,1)
        EndIf
        idx -=1
    EndWhile
EndFunction

Function AddActortoTeamList(Actor akTeammate, Form[] akActorArray, Form[] akExlusionList, Int aiMode = 1) global
    ;/ by default use Mode 2
       Mode 1 (default) use to add non-supported follower to your array
       Mode 2 add NPC to an exclusion list
       Array used by mode 2 & 3 are configurable as user can wish to add or remove some followers depeding of mod purposes.
       To use it you must declare
    /;
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    int IsinExclusionList = ArrayHasForm(akExlusionList,akTeammate)
    If IsinExclusionList == -1
        If aiMode == 1
            ArrayAddForm(akActorArray,akTeammate)
        Elseif aiMode == 2
            ArrayAddForm(akExlusionList, akTeammate)
        EndIf
        SMFDebugInfo("teammate = "+ akTeammate); for testing purpose
    EndIf
EndFunction

Function ResetTeammateList(Form[] akClearedArray = none, Int aiMode = 2) global
    ;/  Convenient function to reset follower/teammate
        Mode 1 Reset auto-filled teammate list
        Mode 2 reset the indicated one.
    /;
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    If aiMode == 1
        ArrayClearForm(SMF._SMFAutoTeamAliases)
    ElseIf aiMode == 2
        ArrayClearForm(akClearedArray)
    EndIf
EndFunction

Function RefillTeamQuestAlias() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    If !SMF._SMF_AutoDetectTeam.IsStopped()
        SMF._SMF_AutoDetectTeam.Reset()
        SMF._SMF_AutoDetectTeam.Stop()
        int i99 = 0
        while !SMF._SMF_AutoDetectTeam.IsStopped() && i99 < 50
            Utility.Wait(0.1)
            i99 += 1
        endWhile            
    EndIf
    SMF._SMF_AutoDetectTeam.Start()    
EndFunction