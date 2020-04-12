Scriptname _SMF_SelfUpdate extends Quest Hidden 

Float Property fVersion Auto
Quest Property _SMFSystem Auto ; Main quest
Quest Property _SMF_AutoDetectTeam Auto
_SMF_API property SMF Auto
;===============  VARIABLES   ==========================================;
bool bMCMready = false
int iWaitSeconds
int iMCMregdelay = 10
int iMaxWait = 30
;===============  Utilities   ==========================================;
import _SMF_ArrayUtils
;===============    EVENTS    ==========================================;
Event OnInit()
  Maintenance()
EndEvent
;Needed code if MCM is updated
;Event OnConfigManagerReady(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
;	bMCMready = true
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
        Int I1 = SMF._SMF_WFallAmb.Getsize()
        While I1 > 0
            Form WfallForm = SMF._SMF_WFallAmb.GetAt(I1) as Form
    
            Bool AddingForm = ArrayAddForm(SMF._SMF_WFallAmbArray, WfallForm)
            If Addingform
                I1 -= 1
            Else
                Debug.Notification("Fail to fill Ambient Array " + I1 + "/" + SMF._SMF_WFallAmb.Getsize())
                I1 = -1
            EndIf
        EndWhile
        Int I2 = SMF._SMF_WFallTop.Getsize()
        While I2 > 0
            Form WfallForm = SMF._SMF_WFallTop.GetAt(I2) as Form
            Bool AddingForm = ArrayAddForm(SMF._SMF_WFallTopArray, WfallForm)
            If Addingform
                I2 -= 1
            Else
                Debug.Notification("Fail to fill Top Array " + I2 + "/" + SMF._SMF_WFallTop.Getsize() )
                I2 = -1
            EndIf
        EndWhile
        
        Int I3 = SMF._SMF_WFallBtom.Getsize()
        While I3 > 0
            Form WfallForm = SMF._SMF_WFallBtom.GetAt(I3) as Form
    
            Bool AddingForm = ArrayAddForm(SMF._SMF_WFallBtomArray, WfallForm)
            If Addingform
                I3 -= 1
            Else
                Debug.Notification("Fail to fill Btom Array " + I3 + "/" + SMF._SMF_WFallBtom.Getsize())
                I3 = -1
            EndIf
        EndWhile
        ;We reset Amno list      
        ArrayClearForm(SMF._SMF_AmmoListArray)
        SMF._SMF_DLC1Detection = 0
        SMF._SMF_DLC2Detection = 0
        Int I4 = SMF._SMF_AmmoList.Getsize()
        While I4 > 0
            Form AmnoForm = SMF._SMF_AmmoList.GetAt(I4) as Form
    
            Bool AddingForm = ArrayAddForm(SMF._SMF_AmmoListArray, AmnoForm)
            If Addingform
                I4 -= 1
            Else
                Debug.Notification("Fail to fill Amnolist " + I4 + "/" + SMF._SMF_AmmoList.Getsize())
                I4 = -1
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
        ;int i2 = 0
        ;while !bMCMready && i2 < 50
        ;    Utility.Wait(0.1)
        ;    i2 += 1
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