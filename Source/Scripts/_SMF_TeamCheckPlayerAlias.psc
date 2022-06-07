Scriptname _SMF_TeamCheckPlayerAlias extends ReferenceAlias  
;===============  PROPERTIES  ==========================================;
_SMF_API property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
import _SMF_TeamUtils
;===============  VARIABLES   ==========================================;
Actor DialogTarget
Actor PreviousTarget
Bool DialogTargetwasTeammate
Bool Busy = false
;===============    EVENTS    ==========================================;
event OnInit()
    RegisterForMenu("Dialogue Menu")
endevent

Event OnPlayerLoadGame()
    If SMF.bEnableTeamSupport
        RefillTeamQuestAlias()
    Endif
endevent

Event OnMenuOpen(String MenuName)
    If SMF.bEnableTeamSupport
        If MenuName == "Dialogue Menu"
            if Busy == false
                Busy = true
                DialogTarget = GetPlayerDialogueTarget()
                If DialogTarget
                    If DialogTarget.IsPlayerTeammate()
                        DialogTargetwasTeammate = true
                    Else
                        DialogTargetwasTeammate = false
                    Endif
                Endif
            Else
                PreviousTarget = DialogTarget
            Endif
            SMFDebugInfo("Dialog Target is: "+ DialogTarget); for testing purpose
            SMFDebugInfo("Dialog Target was Teammate : "+ DialogTargetwasTeammate); for testing purpose
        ElseIf MenuName == "Sleep/Wait"
            RefillTeamQuestAlias()
        EndIf
    endif
EndEvent

Event OnMenuClose(String MenuName)
    If SMF.bEnableTeamSupport
        If MenuName == "Dialogue Menu"
            If DialogTarget && DialogTarget != PreviousTarget
                RegisterForSingleUpdate(10)
            EndIf
        EndIf
    EndIf
EndEvent

Event OnUpdate()
    If SMF.bEnableTeamSupport
        SMFDebugInfo("Closing dialogue menu"); for testing purpose
        SMFDebugInfo("Dialog Target is Teammate now: " + DialogTarget.IsPlayerTeammate())
        If (DialogTarget.IsPlayerTeammate() && !DialogTargetwasTeammate) || (!DialogTarget.IsPlayerTeammate() && DialogTargetwasTeammate)
            RefillTeamQuestAlias()
        EndIf
        Busy = false
        PreviousTarget = none
    EndIf
EndEvent