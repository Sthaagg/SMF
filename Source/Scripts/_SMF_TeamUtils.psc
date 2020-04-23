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
    DebugInfo("idx = "+ idx); for testing purpose
	While idx > 0
		idx -= 1
		ReferenceAlias nthAlias = SMF._SMF_AutoDetectTeam.GetNthAlias(idx) as ReferenceAlias
        If nthAlias
			Actor teammate = nthAlias.GetActorReference()
            AddActortoTeamList(teammate,SMF._SMFAutoTeamAliases,akExlusionList,1)
        EndIf
    EndWhile
EndFunction

Function AddActortoTeamList(Actor akTeammate, Form[] akActorArray, Form[] akExlusionList, Int akMode = 1) global
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
        If akMode == 1
            ArrayAddForm(akActorArray,akTeammate)
        Elseif akMode == 2
            ArrayAddForm(akExlusionList, akTeammate)
        EndIf
        DebugInfo("teammate = "+ akTeammate); for testing purpose
    EndIf
EndFunction

Function ResetTeammateList(Form[] akClearedArray = none, Int akMode = 2) global
    ;/  Convenient function to reset follower/teammate
        Mode 1 Reset auto-filled teammate list
        Mode 2 reset the indicated one.
    /;
	_SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
    endif
    If akMode == 1
        ArrayClearForm(SMF._SMFAutoTeamAliases)
    ElseIf akMode == 2
        ArrayClearForm(akClearedArray)
    EndIf
EndFunction