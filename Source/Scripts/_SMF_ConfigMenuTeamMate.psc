Scriptname _SMF_ConfigMenuTeamMate extends nl_mcm_module  
;===============  PROPERTIES  ==========================================;
_SMF_API property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
import _SMF_TeamUtils
;===============  VARIABLES   ==========================================;

;===============    EVENTS    ==========================================;

event OnInit()
	RegisterModule("Manage teammate", 100)
endevent

event OnPageDraw()
    SetCursorFillMode(TOP_TO_BOTTOM)
    AddHeaderOption(FONT_PRIMARY("Teammate support settings"))
    AddParagraph("Use this page to manage NPCs supported by all mods using this framework.\nClicking on an NPC in the Supported NPCs (max 10) list will move it to the Excluded NPCs list.\nClicking on an NPC in the Excluded NPCs or Manually Supported NPCs list will remove it.")
    AddEmptyOption()
    AddEmptyOption()
    AddTextOptionST("AddaimedNPCs", "", FONT_INFO("Add aimed NPC"))
    AddToggleOptionST("bEnableTeamSupportState", "Enable Teammate support", SMF.bEnableTeamSupport)
    ; Right side
    SetCursorPosition(1)
    AddHeaderOption("Supported Npcs")
    AddEmptyOption()
    if SMF._SMFAutoTeamAliases[0]
    AddTextOptionST("removefollow1", "", FONT_INFO("Follower 1: " + (SMF._SMFAutoTeamAliases[0] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[1]
    AddTextOptionST("removefollow2", "", FONT_INFO("Follower 2: " + (SMF._SMFAutoTeamAliases[1] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[2]
    AddTextOptionST("removefollow3", "", FONT_INFO("Follower 3: " + (SMF._SMFAutoTeamAliases[2] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[3]
    AddTextOptionST("removefollow4", "", FONT_INFO("Follower 4: " + (SMF._SMFAutoTeamAliases[3] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[4]
    AddTextOptionST("removefollow5", "", FONT_INFO("Follower 5: " + (SMF._SMFAutoTeamAliases[4] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[5]
    AddTextOptionST("removefollow6", "", FONT_INFO("Follower 6: " + (SMF._SMFAutoTeamAliases[5] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[6]
    AddTextOptionST("removefollow7", "", FONT_INFO("Follower 7: " + (SMF._SMFAutoTeamAliases[6] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[7]
    AddTextOptionST("removefollow8", "", FONT_INFO("Follower 8: " + (SMF._SMFAutoTeamAliases[7] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[8]
    AddTextOptionST("removefollow9", "", FONT_INFO("Follower 9: " + (SMF._SMFAutoTeamAliases[8] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFAutoTeamAliases[9]
    AddTextOptionST("removefollow10", "", FONT_INFO("Follower 10: " + (SMF._SMFAutoTeamAliases[9] As Actor).getLeveledActorbase().getName() as String))
    endif

    AddHeaderOption("Excluded Npcs")
    AddEmptyOption()
    if SMF._SMFTeamExcludedAliases[0]
    AddTextOptionST("removeExfollow1", "", FONT_INFO("Follower 1: " + (SMF._SMFTeamExcludedAliases[0] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[1]
    AddTextOptionST("removeExfollow2", "", FONT_INFO("Follower 2: " + (SMF._SMFTeamExcludedAliases[1] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[2]
    AddTextOptionST("removeExfollow3", "", FONT_INFO("Follower 3: " + (SMF._SMFTeamExcludedAliases[2] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[3]
    AddTextOptionST("removeExfollow4", "", FONT_INFO("Follower 4: " + (SMF._SMFTeamExcludedAliases[3] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[4]
    AddTextOptionST("removeExfollow5", "", FONT_INFO("Follower 5: " + (SMF._SMFTeamExcludedAliases[4] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[5]
    AddTextOptionST("removeExfollow6", "", FONT_INFO("Follower 6: " + (SMF._SMFTeamExcludedAliases[5] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[6]
    AddTextOptionST("removeExfollow7", "", FONT_INFO("Follower 7: " + (SMF._SMFTeamExcludedAliases[6] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[7]
    AddTextOptionST("removeExfollow8", "", FONT_INFO("Follower 8: " + (SMF._SMFTeamExcludedAliases[7] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[8]
    AddTextOptionST("removeExfollow9", "", FONT_INFO("Follower 9: " + (SMF._SMFTeamExcludedAliases[8] As Actor).getLeveledActorbase().getName() as String))
    endif
    if SMF._SMFTeamExcludedAliases[9]
    AddTextOptionST("removeExfollow10", "", FONT_INFO("Follower 10: " + (SMF._SMFTeamExcludedAliases[9] As Actor).getLeveledActorbase().getName() as String))
    endif

    AddHeaderOption("Manually Supported NPCs")
    AddEmptyOption()
    If SMF._SMFForcedTeamAliases[0]
    AddTextOptionST("removeManFollower1", "", FONT_INFO("Follower 1: " + (SMF._SMFForcedTeamAliases[0] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[1]
    AddTextOptionST("removeManFollower2", "", FONT_INFO("Follower 2: " + (SMF._SMFForcedTeamAliases[1] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[2]
    AddTextOptionST("removeManFollower3", "", FONT_INFO("Follower 3: " + (SMF._SMFForcedTeamAliases[2] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[3]
    AddTextOptionST("removeManFollower4", "", FONT_INFO("Follower 4: " + (SMF._SMFForcedTeamAliases[3] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[4]
    AddTextOptionST("removeManFollower5", "", FONT_INFO("Follower 5: " + (SMF._SMFForcedTeamAliases[4] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[5]
    AddTextOptionST("removeManFollower6", "", FONT_INFO("Follower 6: " + (SMF._SMFForcedTeamAliases[5] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[6]
    AddTextOptionST("removeManFollower7", "", FONT_INFO("Follower 7: " + (SMF._SMFForcedTeamAliases[6] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[7]
    AddTextOptionST("removeManFollower8", "", FONT_INFO("Follower 8: " + (SMF._SMFForcedTeamAliases[7] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[8]
    AddTextOptionST("removeManFollower9", "", FONT_INFO("Follower 9: " + (SMF._SMFForcedTeamAliases[8] As Actor).getLeveledActorbase().getName() as String))
    endif
    If SMF._SMFForcedTeamAliases[9]
    AddTextOptionST("removeManFollower10", "", FONT_INFO("Follower 10: " + (SMF._SMFForcedTeamAliases[9] As Actor).getLeveledActorbase().getName() as String))
    endif
endevent
;===============    STATES    ==========================================;
State bEnableTeamSupportState
    event OnHighlightST(string state_id)
        SetInfoText("Enable SMF teammate support")
    endevent

    event OnSelectST(string state_id)
        SMF.bEnableTeamSupport = !SMF.bEnableTeamSupport
        SetToggleOptionValueST(SMF.bEnableTeamSupport, false, "bEnableTeamSupportState")
        If SMF.bEnableTeamSupport
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
        Else
            SMF._SMF_AutoDetectTeam.Reset()
            SMF._SMF_AutoDetectTeam.Stop()
        EndIf
    endevent
EndState

state AddaimedNPCs
    event OnSelectST(string state_id)
        Actor AimedActor = Game.GetCurrentCrosshairRef() as Actor
        String AimedActorName = AimedActor.getLeveledActorbase().getName() as String
        SMFDebugInfo("aimed actor added"); for testing purpose
        AddActortoTeamList(AimedActor,SMF._SMFForcedTeamAliases,SMF._SMFTeamExcludedAliases)
    endevent

    event OnHighlightST(string state_id)
        SetInfoText("Add aimed NPC to the Manually Supported NPCs list.")
        ;This is the text that will show at the bottom of the page.
    endEvent
endstate

state refresh_mcm
    event OnSelectST(string state_id)
        ForcePageListReset()
    endevent
endstate