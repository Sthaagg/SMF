Scriptname _SMF_API extends Quest Hidden
{Properties needed}
Actor Property PlayerRef Auto
Bool Property bIsFrostfallisLoaded = false Auto hidden
Int	Property _SMF_DLC1Detection = 0 Auto Hidden
Int	Property _SMF_DLC2Detection = 0 Auto Hidden
GlobalVariable Property Gamehour Auto
;Required by _SMF_WaterUtils Script
ActorBase Property WaterTestActor Auto
FormList Property _SMF_WFallTop Auto ;Static object that you can found at top
FormList Property _SMF_WFallBtom Auto ; Static object that you can found at bottom
FormList Property _SMF_WFallAmb Auto; Ambiant sound help for small waterfall
Form[] Property _SMF_WFallTopArray Auto Hidden; Array filled with corresponding formlist for performance sake
Form[] Property _SMF_WFallBtomArray Auto Hidden; Array filled with corresponding formlist for performance sake
Form[] Property _SMF_WFallAmbArray Auto Hidden; Array filled with corresponding formlist for performance sake
Int Property iWfallTopArray Auto Hidden; Store Array max size for performance sake, useful when you need a 'while' avoid to ount each time.
Int Property iWfallBtomArray Auto Hidden; Store Array max size for performance sake, useful when you need a 'while' avoid to ount each time.
Int Property iWfallAmbArray Auto Hidden; Store Array max size for performance sake, useful when you need a 'while' avoid to ount each time.
;Required by _SMF_EquipUtils Script
Formlist Property _SMF_AmmoList Auto
Form[] Property _SMF_AmmoListArray Auto Hidden; (Array populated by script , useful if list are updated)
Keyword Property VendorItemArrow Auto 
Armor Property JewelryRingGold Auto
;Required by _SMF_Teamutils Script
Quest Property _SMF_AutoDetectTeam Auto
Form[] Property _SMFAutoTeamAliases Auto Hidden; Empty, Store teammates detected by autodetect quest
;Formlist Property _SMFForcedTeamAliases Auto ; Empty, Store manual added
;Formlist Property _SMFTeamExcludedAliases Auto ; Empty, Store NPCs which must be ignored

;Required by _SMF_LocationUtils
Bool Property bIsUnderShelter = False Auto hidden
Activator Property _SMF_ShelterDetector Auto
Activator Property _SMF_ShelterDetectorSensor Auto
Spell Property _SMF_ShelterDetectBeamFar Auto
Spell Property _SMF_ShelterDetectBeamNear Auto
; I tried to regroup location by danger level and something i would call healthyness (Unhealthy : disease, poison or anything about you can think, not a place to rest, Healthy : Disease, poison or anything else, a place whe you can rest)
; It should helps to answer of most mod needs. Take a look to script for more inormation.
Formlist Property _SMF_SupernaturalAndultraUnhealthyPlace Auto
; Very Dangerous / Ultra Unhealthy
; dragon priest lair, draugr crypt, falmer hive, hagraven nest, vampire lair, warlock lair, werebear lair, werewolf lair
; places that are filthy, where those that use it are either themselves disease-ridden or don't care about disease due to immunity
Formlist Property _SMF_AbandonnedAndVeryUnhealthyPlace Auto
; Very Dangerous / Very Unhealthy (but less as the previous one)
; ash spawn lair, cemetary, dungeon, jail, nordic ruin
; places that tend to be very dirty, where measures rarely / never take place to prevent disease (abandoned, ignored, etc)
Formlist Property _SMF_CampAndHighUnhealthyPlace Auto
; High Dangerous / High unhealthy (but less as the previous one)
; animal den, Non-Human camp (giant, riekling), shipwreck
; places that tend to be dirty, but where measures (however minimal) are regularly taken to prevent disease not Human standard
; (ship wreck is an exception, added due to being cleaner than the prior - only due to being in water)
Formlist Property _SMF_CampAndAverageUnhealthyPlace Auto
; Dangerous (not always) / Average unhealthy (less as the previous one)
; Human camp (bandit, forsworn), barracks, military camp, military fort, ship
; places that tend to be dirty due to human promiscuity, but where measures (however minimal) are regularly taken to prevent disease
Formlist Property _SMF_DwemerAndLowUnhealthyPlace Auto
; Very Dangerous / Low unhealthy (less as the previous one)
; Dwemer ruin, dwemer automaton area
; places not particularly dirty, but perhaps favorable to diseases enduring / spreading
Formlist Property _SMF_CaveAndLowUnhealthyPlace Auto
; Dangerous / Low unhealthy (less as the previous one)
; cave, ice cave, mine
; places not particularly dirty, but perhaps favorable to diseases enduring / spreading due to their nature
Formlist Property _SMF_LowPopulatedAndLowHealthyPlace Auto
;Low Safe / Low healthy (better as the previous one)
; farm, outdoors, orc stronghold
; default: the great outdoors, farms, etc, few people large area
Formlist Property _SMF_PopulatedSafeAndAverageHealthyPlace Auto
; Safe / Average Healthy (better as the previous one)
; castle, lumber mill, store, settlement, town
; regularly inhabited, but more likely to be dirty than a home / inn
Formlist Property _SMF_SupernaturalAndHighHealthyPlace Auto
; Very dangerous / High Healthy
; Dragon Lair, Spriggan Grove, Pillar (I put this one last, so it is easy to ignore)
; a place where - due to sacred reasons - disease / filth are supernaturally repressed
Formlist Property _SMF_PopulatedAndHighHealthyPlace Auto
; Very Save / High Healthy
; dwelling, homestead, house, inn, pillar (DLC2),
; a decent place to stay for a while, where cleaning occurs semi-regularly and filth and disease are uncommon
Formlist Property _SMF_SafeAndUltraHealthyPlace Auto
; Ultra Safe / Ultra Healthy
; player home, temple
; a place where disease and filth is rare
KeyWord[] property SupernaturalAndultraUnhealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property AbandonnedAndVeryUnhealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property CampAndHighUnhealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property CampAndAverageUnhealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property DwemerAndLowUnhealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property CaveAndLowUnhealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property LowPopulatedAndLowHealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property PopulatedSafeAndAverageHealthyArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property SupernaturalAndHighHealthyArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property PopulatedAndHighHealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
KeyWord[] property SafeAndUltraHealthyPlaceArray Auto hidden;Array filled with corresponding formlist for performance sake
;Required by _SMF_Utils Script
FormList Property _SMF_FurnitureSit Auto


;Activate Debug Mode for testing purpose
Bool Property GeneralDebug  Auto