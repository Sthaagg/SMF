Scriptname _SMF_ConfigMenuCore extends nl_mcm_module  
;===============  PROPERTIES  ==========================================;
_SMF_ConfigMenuEquipUtils property EquipUtils auto
_SMF_ConfigMenuTeamMate property TeamMateUtils auto
;/
bool property ShowTeamMatePage hidden
	function Set(bool show)
		if show
			TeamMateUtils.RegisterModule("TeamMate", 100)
		else
			TeamMateUtils.UnregisterModule()
		endif

		_show_teammate = show
	endfunction

	bool function Get()
		return _show_teammate
	endfunction
endproperty
/;
_SMF_API property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
import _SMF_TeamUtils
;===============  VARIABLES   ==========================================;
;bool _show_teammate
;===============    EVENTS    ==========================================;
event OnInit()
    RegisterModule("Core")
endevent

event OnPageInit()
    SetModName("Sthaagg Memnochs Framework")
    SetLandingPage("Core")
endevent

event OnPageDraw()
    SetCursorFillMode(TOP_TO_BOTTOM)
    
    ; Left side
    AddHeaderOption(FONT_PRIMARY("One MCM to rules them all"))
    AddParagraph("All settings shared across mods using Simple Mod Framework are configurable here.")

    ; Right side
	SetCursorPosition(1)
	;/
	AddHeaderOption(FONT_PRIMARY("Pages"))    
	if ShowTeamMatePage
		AddTextOptionST("mod_show_TeamMate", FONT_WARNING("Hide"), "TeamMate")
	else
		AddTextOptionST("mod_show_TeamMate", FONT_SUCCESS("Show"), "TeamMate")
	endif


    EquipUtils.RegisterModule("EquipUtils", 1000)



	AddEmptyOption()
	/;
	AddHeaderOption(FONT_PRIMARY("Exit MCM?"))
	AddTextOptionST("refresh_mcm", "", FONT_DANGER("Refresh pages"))
	AddTextOptionST("exit_mcm", "", FONT_DANGER("Exit Now!"))
endevent


event OnConfigClose()
	DEBUG_MSG("Config closed!")
endevent

;===============    STATES    ==========================================;
;/
state mod_show_TeamMate
	event OnHighlightST(string state_id)
		SetInfoText("Show TeamMAte page")
	endevent

	event OnSelectST(string state_id)
		ShowTeamMatePage = !ShowTeamMatePage
		ForcePageListReset()
	endevent
endstate
/;

state refresh_mcm
	event OnSelectST(string state_id)
		ForcePageListReset()
	endevent
endstate

state exit_mcm
	event OnSelectST(string state_id)
		CloseMCM(close_journal = true)
	endevent
endstate