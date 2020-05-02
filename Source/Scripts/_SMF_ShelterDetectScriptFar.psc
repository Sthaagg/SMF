Scriptname _SMF_ShelterDetectScriptFar extends ObjectReference  
;===============  PROPERTIES  ==========================================;
_SMF_API Property SMF Auto
;===============  UTILITIES   ==========================================;
import _SMF_Utils
;===============  VARIABLES   ==========================================;
;===============  EVENTS      ==========================================;
Event OnInit()
    float distance = self.GetDistance(SMF.PlayerRef)
    If distance > 1200
        SMF.bIsUnderShelter = false
        SMFDebugInfo( "IsUnderShelter: " + SMF.bIsUnderShelter + "(Dist: " + distance +") (Detector: " + self + ")",2)
    EndIf
    self.disable()
    Self.Delete()
EndEvent
;===============  FUNCTIONS   ==========================================;