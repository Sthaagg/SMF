Scriptname _SMF_ShelterDetectionPerk extends Perk
;===============  PROPERTIES  ==========================================;
_SMF_API Property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
;===============  VARIABLES   ==========================================;
;===============  EVENTS      ==========================================;
Event OnInit()
    DebugInfo("Perk Init")
    DetectShelter()
    registerforSingleupdate(10.0)
EndEvent

Event Onupdate()
    DebugInfo("Perk Update")
    DetectShelter()
    registerforSingleupdate(10.0)
EndEvent

;===============  FUNCTIONS   ==========================================;

Function DetectShelter()
    ObjectReference Detector = SMF.PlayerRef.PlaceAtMe(SMF._SMF_ShelterDetector)
    ObjectReference Sensor = SMF.PlayerRef.PlaceAtMe(SMF._SMF_ShelterDetectorSensor)
    utility.wait(0.25); wait before move
    Detector.MoveTo(SMF.PlayerRef, 0.0, 0.0, 200.0)
    Sensor.MoveTo(SMF.PlayerRef, 0.0, 0.0, 1200.0)
    utility.wait(0.25); wait before cast
    SMF._SMF_ShelterDetectBeamNear.Cast(Detector, Sensor)
    SMF._SMF_ShelterDetectBeamFar.Cast(Detector, Sensor)
    utility.wait(0.25) ; Wait beofre cleaning
    Detector.disable()
    Sensor.Disable()
    Detector.Delete()
    Sensor.Delete()
EndFunction