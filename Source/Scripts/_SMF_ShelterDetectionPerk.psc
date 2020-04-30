Scriptname _SMF_ShelterDetectionPerk extends Perk
;===============  PROPERTIES  ==========================================;
_SMF_API Property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
;===============  VARIABLES   ==========================================;
;===============  EVENTS      ==========================================;
Event OnInit()
    DetectShelter()
    registerforSingleupdate(10.0)
EndEvent

Event Onupdate()
    DetectShelter()
    registerforSingleupdate(10.0)
EndEvent

;===============  FUNCTIONS   ==========================================;

GlobalVariable function Get_Frost_IsTakingShelter()
    return Game.GetFormFromFile(0x00068118, "Frostfall.esp")  as GlobalVariable
EndFunction

Function DetectShelter()
    If !SMF.PlayerRef.IsinInterior()
        If SMF.bIsFrostfallisLoaded
            GlobalVariable IsTakingShelter = Get_Frost_IsTakingShelter()
             if  IsTakingShelter.GetValueInt() == 2
                SMF.bIsUnderShelter = true
                DebugInfo("Frostfall compatibility mode: Shelter detected",2)
            ElseIf IsTakingShelter.GetValueInt() == 1
                SMF.bIsUnderShelter = false
                DebugInfo("Frostfall compatibility mode:No Shelter detected",2)
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
    Else
        SMF.bIsUnderShelter = false
    EndIf
EndFunction