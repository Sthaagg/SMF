Scriptname _SMF_ShelterDetectionPerk extends Perk
;===============  PROPERTIES  ==========================================;
_SMF_API Property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
;===============  VARIABLES   ==========================================;
;===============  EVENTS      ==========================================;
Event OnInit()
    registerforsleep()
    DetectShelter()
    registerforSingleupdate(10.0)
EndEvent

Event Onupdate()
    SMF.bIsUnderCampfireTent = false
    DetectShelter()
    registerforSingleupdate(10.0)
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
    SMF.bIsUnderCampfireTent = false
    DetectShelter()
EndEvent
;===============  FUNCTIONS   ==========================================;

GlobalVariable function Get_Frost_IsTakingShelter()
    return Game.GetFormFromFile(0x00068118, "Frostfall.esp")  as GlobalVariable
EndFunction

CampfireAPI function Get_Campfire()
    return (Game.GetFormFromFile(0x00024095, "Campfire.esm") as Quest) as CampfireAPI
EndFunction

Function DetectShelter()
    If !SMF.PlayerRef.IsinInterior()
        SMFDebugInfo("Player is not in an interior",2)
        If SMF.bIsCampingIsLoaded
            SMFDebugInfo("Campfire is loaded",2)
            CampfireAPI Campfire = Get_Campfire()
            If Campfire.CurrentTent
                If !Campfire.CurrentTent.GetBaseObject().HasKeyword(Campfire.isCampfireTentNoShelter)
                    SMFDebugInfo("Campfire compatibility mode: Sheltered Tent detected",2)
                    SMF.bIsUnderShelter = true
                    SMF.bIsUnderCampfireTent = true
                Else
                    SMFDebugInfo("Campfire compatibility mode: No Sheltered Tent detected",2)
                    SMF.bIsUnderShelter = false
                    SMF.bIsUnderCampfireTent = false
                EndIf
            Else
                SMFDebugInfo("Campfire tent is not used",2)
            EndIf
        EndIf
        If !SMF.bIsUnderCampfireTent
            If SMF.bIsFrostfallisLoaded
                GlobalVariable IsTakingShelter = Get_Frost_IsTakingShelter()
                if IsTakingShelter.GetValueInt() == 2
                    SMF.bIsUnderShelter = true
                    SMFDebugInfo("Frostfall compatibility mode: Shelter detected",2)
                ElseIf IsTakingShelter.GetValueInt() == 1
                    SMF.bIsUnderShelter = false
                    SMFDebugInfo("Frostfall compatibility mode:No Shelter detected",2)
                EndIf
            Else
                ObjectReference Detector = SMF.PlayerRef.PlaceAtMe(SMF._SMF_ShelterDetector)
                ObjectReference Sensor = SMF.PlayerRef.PlaceAtMe(SMF._SMF_ShelterDetectorSensor)
                utility.wait(0.25); wait before move
                Detector.MoveTo(SMF.PlayerRef, 0.0, 0.0, 200.0); place Detector above player
                Sensor.MoveTo(SMF.PlayerRef, 0.0, 0.0, 1200.0); place Sensor far above player
                utility.wait(0.25); wait before cast
                SMF._SMF_ShelterDetectBeamNear.Cast(Detector, Sensor)
                SMF._SMF_ShelterDetectBeamFar.Cast(Detector, Sensor)
                utility.wait(0.25) ; Wait before cleaning
                Detector.disable()
                Sensor.Disable()
                Detector.Delete()
                Sensor.Delete()
            EndIf
        EndIf
    Else
        SMF.bIsUnderShelter = false
    EndIf
EndFunction