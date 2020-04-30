Scriptname _SMF_SelfUpdate extends Quest Hidden 

Float Property fVersion Auto
Quest Property _SMFSystem Auto ; Main quest
Quest Property _SMF_AutoDetectTeam Auto
_SMF_API property SMF Auto
_SMF_Compatibility Property Compatibility Auto
;===============  VARIABLES   ==========================================;
bool _bMCMready = false
int _iWaitSeconds
int _iMCMregdelay = 10
int _iMaxWait = 30
;===============  Utilities   ==========================================;
import _SMF_ArrayUtils
;===============    EVENTS    ==========================================;
Event OnInit()
  Maintenance()
  Compatibility.Moddetection()
EndEvent
;Needed code if MCM is updated
;Event OnConfigManagerReady(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
;	_bMCMready = true
;endEvent
;===============    Functions  ==========================================;
Function Maintenance()

	If fVersion < 1.0 ; <--- Edit this value when updating
        Debug.Notification("Better Face lighting initializing")
		fVersion = 1.0 ; and this
        ; Update Code
        ;-------SKSE-Version-Check-------------------------------------
	    If !(SKSE.GetVersionRelease() >= 48)
    	    Debug.Notification("Please install Skyrim Script Extender (SKSE) version 1.7.3 or higher.")
	    	return
	    EndIf
        
        _SMFSystem.Reset()
		_SMFSystem.Stop()
        ;We must wait until the quest has stopped before restarting the quest. Using Stop() and immediately Start() may fail. 
        ;Continue after 5 seconds to prevent infinite loop.
        int i = 0
        while !_SMFSystem.IsStopped() && i < 50
            Utility.Wait(0.1)
            i += 1
        endWhile
        _SMFSystem.Start()
        ;------Initializing Array--------------------------------------
        SMF._SMFAutoTeamAliases = new Form[10]
        SMF._SMF_WFallTopArray = new Form[19]
        SMF._SMF_WFallBtomArray = new Form[16]
        SMF._SMF_WFallAmbArray = new Form[17]
        SMF._SMF_AmmoListArray = new Form[128]
         ;------Filling Array-------------------------------------------
        Debug.Notification("Enabling Water Support")
        Int i1 = SMF._SMF_WFallAmb.Getsize()
        While i1 > 0
            Form WfallForm = SMF._SMF_WFallAmb.GetAt(i1) as Form
    
            Bool AddingForm = ArrayAddForm(SMF._SMF_WFallAmbArray, WfallForm)
            If Addingform
                i1 -= 1
            Else
                Debug.Notification("Fail to fill Ambient Array " + i1 + "/" + SMF._SMF_WFallAmb.Getsize())
                i1 = -1
            EndIf
        EndWhile
        Int i2 = SMF._SMF_WFallTop.Getsize()
        While i2 > 0
            Form WfallForm = SMF._SMF_WFallTop.GetAt(i2) as Form
            Bool AddingForm = ArrayAddForm(SMF._SMF_WFallTopArray, WfallForm)
            If Addingform
                i2 -= 1
            Else
                Debug.Notification("Fail to fill Top Array " + i2 + "/" + SMF._SMF_WFallTop.Getsize() )
                i2 = -1
            EndIf
        EndWhile
        
        Int i3 = SMF._SMF_WFallBtom.Getsize()
        While i3 > 0
            Form WfallForm = SMF._SMF_WFallBtom.GetAt(i3) as Form
    
            Bool AddingForm = ArrayAddForm(SMF._SMF_WFallBtomArray, WfallForm)
            If Addingform
                i3 -= 1
            Else
                Debug.Notification("Fail to fill Btom Array " + i3 + "/" + SMF._SMF_WFallBtom.Getsize())
                i3 = -1
            EndIf
        EndWhile
        ;We reset Amno list      
        ArrayClearForm(SMF._SMF_AmmoListArray)
        SMF._SMF_DLC1Detection = 0
        SMF._SMF_DLC2Detection = 0
        Int i4 = SMF._SMF_AmmoList.Getsize()
        While i4 > 0
            Form AmnoForm = SMF._SMF_AmmoList.GetAt(i4) as Form
    
            Bool AddingForm = ArrayAddForm(SMF._SMF_AmmoListArray, AmnoForm)
            If Addingform
                i4 -= 1
            Else
                Debug.Notification("Fail to fill Amnolist " + i4 + "/" + SMF._SMF_AmmoList.Getsize())
                i4 = -1
            EndIf
        EndWhile        
        ;Just in case we sort Array to remove blank entries
        ArraySortForm(SMF._SMF_WFallTopArray)
        ArraySortForm(SMF._SMF_WFallBtomArray)
        ArraySortForm(SMF._SMF_WFallAmbArray)
        ArraySortForm(SMF._SMF_AmmoListArray)
        ;We store array Max count to avoid calling counf function to often as following array are static
        SMF.iWfallTopArray = ArrayTotalCountForm(SMF._SMF_WFallTopArray)
        SMF.iWfallBtomArray = ArrayTotalCountForm(SMF._SMF_WFallBtomArray)
        SMF.iWfallAmbArray = ArrayTotalCountForm(SMF._SMF_WFallAmbArray)  
        ;Needed code if MCM is updated
        ;int i5 = 0
        ;while !_bMCMready && i5 < 50
        ;    Utility.Wait(0.1)
        ;    i5 += 1
        ;endWhile
        ;Quest qstMCM = Quest.GetQuest("SKI_ConfigManagerInstance") ;as SKI_ConfigManager
        ;qstMCM.SetStage(1)
        If !_SMF_AutoDetectTeam.IsStopped()
            _SMF_AutoDetectTeam.Reset()
            _SMF_AutoDetectTeam.Stop()
            int i99 = 0
            while !_SMFSystem.IsStopped() && i99 < 50
                Utility.Wait(0.1)
                i99 += 1
            endWhile            
            _SMF_AutoDetectTeam.Start()
        EndIf
        String VNumber = (fVersion as Int) + "." + (((fVersion - (fVersion as Int)) * 100 + 0.001) as Int)
		Debug.Notification("Now running SMF version: " + VNumber)
	EndIf
EndFunction