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
Bool _bDisplayVersionMessage = False
;===============  Utilities   ==========================================;
import _SMF_ArrayUtils
import _SMF_Utils
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
    While fVersion < 1.0
        _bDisplayVersionMessage = true
	    If fVersion < 1.0 ; <--- Edit this value when updating
            Debug.Notification("SMF initializing")
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
            SMF._SMFForcedTeamAliases = new Form[10]
            SMF._SMFTeamExcludedAliases = new Form[10]
            SMF._SMF_WFallTopArray = new Form[19]
            SMF._SMF_WFallBtomArray = new Form[16]
            SMF._SMF_WFallAmbArray = new Form[17]
            SMF._SMF_AmmoListArray = new Form[128]
            SMF.SupernaturalAndultraUnhealthyPlaceArray = new KeyWord[7]
            SMF.AbandonnedAndVeryUnhealthyPlaceArray = new KeyWord[4]
            SMF.CampAndHighUnhealthyPlaceArray = new KeyWord[6]
            SMF.CampAndAverageUnhealthyPlaceArray = new KeyWord[5]
            SMF.DwemerAndLowUnhealthyPlaceArray = new KeyWord[2]
            SMF.CaveAndLowUnhealthyPlaceArray = new KeyWord[3]
            SMF.LowPopulatedAndLowHealthyPlaceArray = new KeyWord[3]
            SMF.PopulatedSafeAndAverageHealthyArray = new KeyWord[6]
            SMF.SupernaturalAndHighHealthyArray = new KeyWord[3]
            SMF.PopulatedAndHighHealthyPlaceArray = new KeyWord[4]
            SMF.SafeAndUltraHealthyPlaceArray = new KeyWord[2]
            ;------Filling Array-------------------------------------------
            Debug.Notification("Enabling Water Support")

            ArrayClearForm(SMF._SMF_WFallAmbArray)
            Int i1 = SMF._SMF_WFallAmb.Getsize()
            While i1 > 0
                Form WfallForm = SMF._SMF_WFallAmb.GetAt(i1 - 1) as Form
                Bool AddingForm = ArrayAddForm(SMF._SMF_WFallAmbArray, WfallForm)
                If Addingform
                    i1 -= 1
                Else
                    Debug.Notification("Fail to fill Ambient Array " + i1 + "/" + SMF._SMF_WFallAmb.Getsize())
                    i1 = -1
                EndIf
            EndWhile

            ArrayClearForm(SMF._SMF_WFallTopArray)
            Int i2 = SMF._SMF_WFallTop.Getsize()
            While i2 > 0
                Form WfallForm = SMF._SMF_WFallTop.GetAt(i2 - 1) as Form
                Bool AddingForm = ArrayAddForm(SMF._SMF_WFallTopArray, WfallForm)
                If Addingform
                    i2 -= 1
                Else
                    Debug.Notification("Fail to fill Top Array " + i2 + "/" + SMF._SMF_WFallTop.Getsize() )
                    i2 = -1
                EndIf
            EndWhile

            ArrayClearForm(SMF._SMF_WFallBtomArray)
            Int i3 = SMF._SMF_WFallBtom.Getsize()
            While i3 > 0
                Form WfallForm = SMF._SMF_WFallBtom.GetAt(i3 - 1) as Form
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
                Form AmnoForm = SMF._SMF_AmmoList.GetAt(i4 - 1) as Form
                Bool AddingForm = ArrayAddForm(SMF._SMF_AmmoListArray, AmnoForm)
                If Addingform
                    i4 -= 1
                Else
                    Debug.Notification("Fail to fill Amnolist " + i4 + "/" + SMF._SMF_AmmoList.Getsize())
                    i4 = -1
                EndIf
            EndWhile
            
            Debug.Notification("Optimize location Support")
            ArrayClearKeyword(SMF.SupernaturalAndultraUnhealthyPlaceArray)
            Int i5 = SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize()
            While i5 > 0
                KeyWord LocKwd = SMF._SMF_SupernaturalAndultraUnhealthyPlace.GetAt(i5 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.SupernaturalAndultraUnhealthyPlaceArray, LocKwd)
                If AddingKWD
                    i5 -= 1
                Else
                    SMFDebugInfo("Fail to fill SupernaturalAndultraUnhealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i5 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.AbandonnedAndVeryUnhealthyPlaceArray)
            Int i6 = SMF._SMF_AbandonnedAndVeryUnhealthyPlace.Getsize()
            While i6 > 0
                KeyWord LocKwd = SMF._SMF_AbandonnedAndVeryUnhealthyPlace.GetAt(i6 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.AbandonnedAndVeryUnhealthyPlaceArray, LocKwd)
                If AddingKWD
                    i6 -= 1
                Else
                    SMFDebugInfo("Fail to fill AbandonnedAndVeryUnhealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i6 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.CampAndHighUnhealthyPlaceArray)
            Int i7 = SMF._SMF_CampAndHighUnhealthyPlace.Getsize()
            While i7 > 0
                KeyWord LocKwd = SMF._SMF_CampAndHighUnhealthyPlace.GetAt(i7 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.CampAndHighUnhealthyPlaceArray, LocKwd)
                If AddingKWD
                    i7 -= 1
                Else
                    SMFDebugInfo("Fail to fill CampAndHighUnhealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i7 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.CampAndAverageUnhealthyPlaceArray)
            Int i8 = SMF._SMF_CampAndAverageUnhealthyPlace.Getsize()
            While i8 > 0
                KeyWord LocKwd = SMF._SMF_CampAndAverageUnhealthyPlace.GetAt(i8 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.CampAndAverageUnhealthyPlaceArray, LocKwd)
                If AddingKWD
                    i8 -= 1
                Else
                    SMFDebugInfo("Fail to fill CampAndAverageUnhealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i8 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.DwemerAndLowUnhealthyPlaceArray)
            Int i9 = SMF._SMF_DwemerAndLowUnhealthyPlace.Getsize()
            While i9 > 0
                KeyWord LocKwd = SMF._SMF_DwemerAndLowUnhealthyPlace.GetAt(i9 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.DwemerAndLowUnhealthyPlaceArray, LocKwd)
                If AddingKWD
                    i9 -= 1
                Else
                    SMFDebugInfo("Fail to fill DwemerAndLowUnhealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i9 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.CaveAndLowUnhealthyPlaceArray)
            Int i10 = SMF._SMF_CaveAndLowUnhealthyPlace.Getsize()
            While i10 > 0
                KeyWord LocKwd = SMF._SMF_CaveAndLowUnhealthyPlace.GetAt(i10 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.CaveAndLowUnhealthyPlaceArray, LocKwd)
                If AddingKWD
                    i10 -= 1
                Else
                    SMFDebugInfo("Fail to fill CaveAndLowUnhealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i10 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.LowPopulatedAndLowHealthyPlaceArray)
            Int i11 = SMF._SMF_LowPopulatedAndLowHealthyPlace.Getsize()
            While i11 > 0
                KeyWord LocKwd = SMF._SMF_LowPopulatedAndLowHealthyPlace.GetAt(i11 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.LowPopulatedAndLowHealthyPlaceArray, LocKwd)
                If AddingKWD
                    i11 -= 1
                Else
                    SMFDebugInfo("Fail to fill LowPopulatedAndLowHealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i11 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.PopulatedSafeAndAverageHealthyArray)
            Int i12 = SMF._SMF_PopulatedSafeAndAverageHealthyPlace.Getsize()
            While i12 > 0
                KeyWord LocKwd = SMF._SMF_PopulatedSafeAndAverageHealthyPlace.GetAt(i12 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.PopulatedSafeAndAverageHealthyArray, LocKwd)
                If AddingKWD
                    i12 -= 1
                Else
                    SMFDebugInfo("Fail to fill PopulatedSafeAndAverageHealthyArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i12 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.SupernaturalAndHighHealthyArray)
            Int i13 = SMF._SMF_SupernaturalAndHighHealthyPlace.Getsize()
            While i13 > 0
                KeyWord LocKwd = SMF._SMF_SupernaturalAndHighHealthyPlace.GetAt(i13 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.SupernaturalAndHighHealthyArray, LocKwd)
                If AddingKWD
                    i13 -= 1
                Else
                    SMFDebugInfo("Fail to fill SupernaturalAndHighHealthyArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i13 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.PopulatedAndHighHealthyPlaceArray)
            Int i14 = SMF._SMF_PopulatedAndHighHealthyPlace.Getsize()
            While i14 > 0
                KeyWord LocKwd = SMF._SMF_PopulatedAndHighHealthyPlace.GetAt(i14 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.PopulatedAndHighHealthyPlaceArray, LocKwd)
                If AddingKWD
                    i14 -= 1
                Else
                    SMFDebugInfo("Fail to fill PopulatedAndHighHealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i14 = -1
                EndIf
            EndWhile

            ArrayClearKeyword(SMF.SafeAndUltraHealthyPlaceArray)
            Int i15 = SMF._SMF_SafeAndUltraHealthyPlace.Getsize()
            While i15 > 0
                KeyWord LocKwd = SMF._SMF_SafeAndUltraHealthyPlace.GetAt(i15 - 1) as Keyword
                Bool AddingKWD = ArrayAddKeyword(SMF.SafeAndUltraHealthyPlaceArray, LocKwd)
                If AddingKWD
                    i15 -= 1
                Else
                    SMFDebugInfo("Fail to fill SafeAndUltraHealthyPlaceArray Array " + i5 + "/" + SMF._SMF_SupernaturalAndultraUnhealthyPlace.Getsize(),2)
                    i15 = -1
                EndIf
            EndWhile
            ;Just in case we sort Array to remove blank entries
            ArraySortForm(SMF._SMF_WFallTopArray)
            ArraySortForm(SMF._SMF_WFallBtomArray)
            ArraySortForm(SMF._SMF_WFallAmbArray)
            ArraySortForm(SMF._SMF_AmmoListArray)
            ArraySortKeyWord(SMF.SupernaturalAndultraUnhealthyPlaceArray)
            ArraySortKeyWord(SMF.AbandonnedAndVeryUnhealthyPlaceArray)
            ArraySortKeyWord(SMF.CampAndHighUnhealthyPlaceArray)
            ArraySortKeyWord(SMF.CampAndAverageUnhealthyPlaceArray)
            ArraySortKeyWord(SMF.DwemerAndLowUnhealthyPlaceArray)
            ArraySortKeyWord(SMF.CaveAndLowUnhealthyPlaceArray)
            ArraySortKeyWord(SMF.LowPopulatedAndLowHealthyPlaceArray)
            ArraySortKeyWord(SMF.PopulatedSafeAndAverageHealthyArray)
            ArraySortKeyWord(SMF.SupernaturalAndHighHealthyArray)
            ArraySortKeyWord(SMF.PopulatedAndHighHealthyPlaceArray)
            ArraySortKeyWord(SMF.SafeAndUltraHealthyPlaceArray)
            ;We store array Max count to avoid calling count function to often as following array are static
            SMF.iWfallTopArray = ArrayTotalCountForm(SMF._SMF_WFallTopArray)
            SMF.iWfallBtomArray = ArrayTotalCountForm(SMF._SMF_WFallBtomArray)
            SMF.iWfallAmbArray = ArrayTotalCountForm(SMF._SMF_WFallAmbArray)  
            SMF.iSupernaturalAndultraUnhealthyPlaceArray = ArrayTotalCountKeyword(SMF.SupernaturalAndultraUnhealthyPlaceArray)
            SMF.iAbandonnedAndVeryUnhealthyPlaceArray = ArrayTotalCountKeyword(SMF.AbandonnedAndVeryUnhealthyPlaceArray)
            SMF.iCampAndHighUnhealthyPlaceArray = ArrayTotalCountKeyword(SMF.CampAndHighUnhealthyPlaceArray)
            SMF.iCampAndAverageUnhealthyPlaceArray = ArrayTotalCountKeyword(SMF.CampAndAverageUnhealthyPlaceArray)
            SMF.iDwemerAndLowUnhealthyPlaceArray = ArrayTotalCountKeyword(SMF.DwemerAndLowUnhealthyPlaceArray)
            SMF.iCaveAndLowUnhealthyPlaceArray = ArrayTotalCountKeyword(SMF.CaveAndLowUnhealthyPlaceArray)
            SMF.iLowPopulatedAndLowHealthyPlaceArray = ArrayTotalCountKeyword(SMF.LowPopulatedAndLowHealthyPlaceArray)
            SMF.iPopulatedSafeAndAverageHealthyArray = ArrayTotalCountKeyword(SMF.PopulatedSafeAndAverageHealthyArray)
            SMF.iSupernaturalAndHighHealthyArray = ArrayTotalCountKeyword(SMF.SupernaturalAndHighHealthyArray)
            SMF.iPopulatedAndHighHealthyPlaceArray = ArrayTotalCountKeyword(SMF.PopulatedAndHighHealthyPlaceArray)
            SMF.iSafeAndUltraHealthyPlaceArray = ArrayTotalCountKeyword(SMF.SafeAndUltraHealthyPlaceArray)
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
                while !_SMF_AutoDetectTeam.IsStopped() && i99 < 50
                    Utility.Wait(0.1)
                    i99 += 1
                endWhile            
                _SMF_AutoDetectTeam.Start()
            EndIf
        EndIf
    EndWhile
    If _bDisplayVersionMessage
        String VNumber = (fVersion as Int) + "." + (((fVersion - (fVersion as Int)) * 100 + 0.001) as Int)
        Debug.Notification("Now running SMF version: " + VNumber)
    EndIf
    SendModEvent("SMF_InitializationDone")
EndFunction