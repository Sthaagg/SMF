Scriptname _SMF_TeamUtils  Hidden 
{_SMF_AutoDetectTeam quest must be started if you want to use AutoDetectTeam() function}
;/ You need to create two array ex:
Form[] Property _SMF_ActorArray Auto Hidden; Empty, Store manual added
Form[] Property _SMF_ExlusionList Auto Hidden; Empty, Store NPCs which must be ignored
/;
import _SMF_Utils
import _SMF_ArrayUtils

Function AutoDetectTeam(form[] ExlusionList) global
    ;/  useful function for mod which manage follower and teammate, it is what I use in Better Facelight or Keep It Clean
        This functiun get the alias from dedicated quest and store them in an Array, this one is hardcoded so it can be shared by any mod which use this function
        due to how follower/temamate are detected it will be a waste of ressource to use different array.
        Nothing to do except starting the dedicated quest _SMF_AutoDetectTeam
    /;
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif  
    int idx  = SMF._SMF_AutoDetectTeam.GetNumAliases()
    If SMF.GeneralDebug
        debug.notification("idx = "+ idx); for testing purpose
    EndIf
	While idx > 0
		idx -= 1
		ReferenceAlias nthAlias = SMF._SMF_AutoDetectTeam.GetNthAlias(idx) as ReferenceAlias
        If nthAlias
			Actor teammate = nthAlias.GetActorReference()
            AddActortoTeamList(teammate,SMF._SMFAutoTeamAliases,ExlusionList,1)
        EndIf
    EndWhile
EndFunction

Function AddActortoTeamList(Actor teammate, Form[] ActorArray, Form[] ExlusionList, Int mode = 1) global
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
    int IsinExclusionList = ArrayHasForm(ExlusionList,teammate)
    If IsinExclusionList == -1
        If mode == 1
            ArrayAddForm(ActorArray,teammate)
        Elseif mode == 2
            ArrayAddForm(ExlusionList, teammate)
        EndIf
        If SMF.GeneralDebug
            debug.notification("teammate = "+ teammate); for testing purpose
        EndIf    
    EndIf
EndFunction

Function ResetTeammateList(Form[] ClearedArray = none, Int mode = 2) global
    ;/  Convenient function to reset follower/teammate
        Mode 1 Reset auto-filled teammate list
        Mode 2 reset the indicated one.
    /;
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    If mode == 1
        ArrayClearForm(SMF._SMFAutoTeamAliases)
    ElseIf mode == 2
        ArrayClearForm(ClearedArray)
    EndIf
EndFunction