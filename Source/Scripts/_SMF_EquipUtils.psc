Scriptname _SMF_EquipUtils  Hidden 
{Optimized Dress / Undress player script, based on Outfit Switcher by White Shadow and Updated Outfit Switcher by Spanksh.
Dress UnDress NPC Script}
Import _SMF_Utils
Import _SMF_ArrayUtils

Bool Function DressUndressPlayer(Form[] ListEquip,form[] ListL, bool Unequiped) global
;/ Script to undress / Dress the player.
To use this script you need to use an array, a form and a bool properties
Ex:
Form[] Property _SMF_EquipList Auto Hidden; (store player outfit)
Form[] Property _SMF_EquipListL Auto Hidden; Store Left hand item
bool property _SMF_UnequipGearAlreadyExecuted = False Auto Hidden; Script status
You must initialise array with this number :
       SMF._SMF_EquipList = new Form[32] ;It is the equip slot number avialable
       SMF._SMF_EquipListL = new Form[1] ;Left hand will need only one slot.
Use this function like this : 
_SMF_UnequipGearAlreadyExecuted = DressUndressPlayer(_SMF_EquipList, _SMF_EquipListL, _SMF_UnequipGearAlreadyExecuted)

First time the function is called it will undress the player, and switch the bool to true
Second time it will dress the player and switch the bool to false.

Danwguard and DragonBorn amnos are added by script to ensure compatibility with mod that requires to disable it (like enderal)
The amnolist use a hardcoded array to share it with other mods wich uses this script to avoid useless multiple detection and ressource sake.
/;
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
	endif
 	Actor PlayerRef = SMF.PlayerRef
    If (SMF._SMF_DLC1Detection == 0)
        If (Game.GetModByName("Dawnguard.esm") != 255)
            AddDawnguardAmmo()
            Debug.Notification("Dawnguard Ammo found. Adding to Memory.")
        EndIf
	EndIf
    If (SMF._SMF_DLC2Detection == 0)
        If (Game.GetModByName("Dragonborn.esm") != 255)
            AddDragonbornAmmo()
            Debug.Notification("Dragonborn Ammo found. Adding to Memory.")
        EndIf
    EndIf
	;Check camera mode
	Int F1StPV = 0
    if SMF.PlayerRef.GetAnimationVariableBool("IsFirstPerson") == True
        F1StPV = 1
        ;debug.Notification("player is in firstPV")
	EndIf
	Closemenu()
	
	Game.ForceThirdPerson()
	Game.DisablePlayerControls(true, true, true, false, false, true, true)
    If (PlayerRef.IsWeaponDrawn())
        PlayerRef.SheatheWeapon()
        Utility.Wait(1.500000)
    Else
    Utility.Wait(0.200000)
    EndIf
    Debug.SendAnimationEvent(PlayerRef, "IdleMQ203EsbernBookEnterInstant")
	
    If !Unequiped
		Unequiped = UnequipGear(ListEquip,ListL)
		If SMF.GeneralDebug
			Debug.Notification("Unequip Mode")
		EndIf
    Else
		Unequiped = EquipGear(ListEquip,ListL)
		Utility.Wait(1.0)
		If SMF.GeneralDebug
			Debug.Notification("Equip Mode")
		EndIf
	EndIF

	;Utility.Wait(1.500000)
	Debug.SendAnimationEvent(PlayerRef, "IdleBracedPain")	
	Debug.SendAnimationEvent(PlayerRef, "IdleStop")
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	Utility.Wait(0.5)
	;Check camera mode
	if F1StPV == 1
		Game.ForceFirstPerson()
		Utility.Wait(0.100000)
	EndIf
	Game.EnablePlayerControls()
	
	return Unequiped

	Debug.Notification("Player regain control")
EndFunction

Function AddDawnguardAmmo() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
	endif
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(2995, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(61856, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(61883, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(61884, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(95988, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(53401, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(61873, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(61879, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(61881, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(39072, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(39073, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(108888, "Dawnguard.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(65283, "Dawnguard.esm")))

	If SMF.GeneralDebug
		Int i = ArrayTotalCountForm(SMF._SMF_AmmoListArray)														;Equip everything else in the reverse order we stored it (including right hand weapons)
		Debug.Notification("ArrayTotalCountForm:" + i)
	EndIf
	SMF._SMF_DLC1Detection = 1
EndFunction


Function AddDragonbornAmmo() global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return None
	endif
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(96032, "Dragonborn.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(156217, "Dragonborn.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(156219, "Dragonborn.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(110287, "Dragonborn.esm")))
	ArrayAddForm(SMF._SMF_AmmoListArray,(game.GetFormFromFile(211361, "Dragonborn.esm")))
	If SMF.GeneralDebug
		Int i = ArrayTotalCountForm(SMF._SMF_AmmoListArray)														;Equip everything else in the reverse order we stored it (including right hand weapons)
		Debug.Notification("ArrayTotalCountForm:" + i)
	EndIf
	SMF._SMF_DLC2Detection = 1
EndFunction

Bool Function UnequipGear(Form[] List, Form[] ListL) global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return False
	endif
	Actor PlayerRef = SMF.PlayerRef

	;-------Armor--------------------------------------------------
	Int slotsChecked
	;	slotsChecked += 0x00100000
	;	slotsChecked += 0x00200000 
    slotsChecked += 0x80000000														;Ignore reserved slots
    Int thisSlot = 0x01
    While (thisSlot < 0x80000000)
        If (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) 					;Only check slots we haven't found anything equipped on already
            Armor thisArmor = PlayerRef.GetWornForm(thisSlot) as Armor
            If (thisArmor)
				ArrayAddForm(List,thisArmor)
				PlayerRef.UnequipItem(thisArmor, false, true)
                slotsChecked += thisArmor.GetSlotMask() 							;Add all slots this item covers to our slotsChecked variable
            Else																	;No armor was found on this slot
                slotsChecked += thisSlot
            EndIf
        EndIf
        thisSlot *= 2																;Double the number to move on to the next slot
    EndWhile
	;--------------------------------------------------------------
	
	
	;-------Ammo---------------------------------------------------
	Form Amno
	Bool AmnoFound = False
	Int n = ArrayTotalCountForm(SMF._SMF_AmmoListArray)

	While (n > 0)
		Amno = (SMF._SMF_AmmoListArray[n] as Form)
		If PlayerRef.IsEquipped(Amno)
			AmnoFound = true
			n = -1
		Else 
			n -= 1
		EndIf
	EndWhile
	If AmnoFound
		ArrayAddForm(List,Amno)
		PlayerRef.UnequipItem(Amno, false, true)
	Else
		Int k = 0
		While (k < 8)																;First check all hotkeys for ammo. This is very quick, so we can always do it, also it works without Keywords
			Form hotkeyItem = Game.GetHotkeyBoundObject(k)
			If (hotkeyItem.GetType() == 42)
				Int FormCount = ArrayHasForm(SMF._SMF_AmmoListArray,hotkeyItem)
				If (FormCount == -1)				;If we found unknown ammo, remember it for the future
					ArrayAddForm(SMF._SMF_AmmoListArray,hotkeyItem)
					Debug.Notification("New Ammo found in Hotkeys. Adding to Memory.")
				EndIf
				If (PlayerRef.IsEquipped(hotkeyItem))									;If we actually found the equipped ammo, proceed as usual
					ArrayAddForm(List,hotkeyItem)
					PlayerRef.UnequipItem(hotkeyItem, false, true)
				EndIf
			EndIf
			k += 1
		EndWhile

		If (PlayerRef.WornHasKeyword(SMF.VendorItemArrow))									;Now we also check the rest of the inventory, but only if the outfit actually includes ammo, that we couldn't find with previous methods
			Debug.SendAnimationEvent(PlayerRef, "IdleBracedPain")						;We use this to interrupt a non-interruptable animation (IdleMQ203EsbernBookEnterInstant)
			Debug.SendAnimationEvent(PlayerRef, "IdleStop")
			Debug.SendAnimationEvent(PlayerRef, "IdleStudy")							;This might take a while so better play an animation as distraction
			Debug.Notification("New Ammo detected. Searching inventory. Please Wait.")
			k = PlayerRef.GetNumItems()
			While k > 0																;Check all items in the inventory for unknown ammo
				k -= 1
				Form inventoryItem = PlayerRef.GetNthForm(k)
				If (inventoryItem.GetType() == 42)
					Int FormCount = ArrayHasForm(SMF._SMF_AmmoListArray,inventoryItem)
					If (FormCount == -1)
						ArrayAddForm(SMF._SMF_AmmoListArray,inventoryItem)
						Debug.Notification("New Ammo found in Inventory. Adding to Memory.")
					EndIf
					If (PlayerRef.IsEquipped(inventoryItem))							;If we actually found the equipped ammo, proceed as usual
						ArrayAddForm(List,inventoryItem)
						PlayerRef.UnequipItem(inventoryItem, false, true)
					EndIf
				EndIf
			EndWhile
			Debug.Notification("Search complete.")
		EndIf

	EndIf
	;-------Right-Hand-Weapons-------------------------------------
	Form RightWeapon = PlayerRef.GetEquippedObject(1)									;Get and store the primary weapon
	If (RightWeapon as Weapon)
		ArrayAddForm(List,RightWeapon)
        PlayerRef.UnequipItem(RightWeapon, false, true)
        If SMF.GeneralDebug
            Debug.Notification("Primary Right Weapon saved")
        EndIf
	EndIf
	
	RightWeapon = PlayerRef.GetEquippedObject(1)										;We repeat this step again, since unequipping a two-handed weapon can equip a previously used one-handed weapon
	If (RightWeapon && !(RightWeapon as Spell))
		ArrayAddForm(List,RightWeapon)
        PlayerRef.UnequipItem(RightWeapon, false, true)
        If SMF.GeneralDebug
            Debug.Notification("Secondary Right Weapon/Item saved")
        EndIf
	EndIf
		;-------Left-Hand-Weapon/Shield--------------------------------
	Form LeftWeapon = PlayerRef.GetEquippedObject(0)								;We process the left hand last, since unequipping a two-handed weapon can equip a previously used one-handed weapon/shield
	If (LeftWeapon && !(LeftWeapon as Spell))
		ArrayAddForm(ListL,LeftWeapon)
        PlayerRef.UnequipItem(LeftWeapon, false, true)
        If SMF.GeneralDebug
            Debug.Notification("Left Weapon/Shield/Item saved")
        EndIf
	EndIf
	If SMF.GeneralDebug
		Debug.Notification("Equiped List: " + ArrayTotalCountForm(List))
		Debug.Notification("Equiped left : " + ArrayTotalCountForm(ListL))
	EndIf
	return True
EndFunction

Bool Function EquipGear(Form[] List, Form[] ListL) global
    _SMF_API SMF = GetAPI()
    if SMF == none
        RaiseSMFAPIError()
        return false
	endif
	Actor PlayerRef = SMF.PlayerRef
	
	;-------Left-Hand-Weapon/Shield--------------------------------
	Form LeftItem = ListL[0]												;Equip left hand (can only be one item)
	If (LeftItem)
		PlayerRef.EquipItemEx(LeftItem, 2, false, false)
	EndIf
	ArrayClearForm(ListL)																	;Clear this list for the next time we switch outfits
	;--------------------------------------------------------------
	;-------Rest---------------------------------------------------
	Int i = ArrayTotalCountForm(List)
	If SMF.GeneralDebug													;Equip everything else in the reverse order we stored it (including right hand weapons)
		Debug.Notification("ArrayTotalCountForm:" + i)
	EndIF
	While (i > 0)
		i -= 1
		Form ListItem = List[i]
		If (ListItem)
			PlayerRef.EquipItemEx(ListItem, 0, false, false)
		EndIf
	EndWhile
	ArrayClearForm(List)																	;Clear this list for the next time we switch outfits
	;--------------------------------------------------------------
	return False
EndFunction

Function DressUndressNPC(Actor akTarget, Int mode) ;Mode 1 unequip gear / Mode 2 reequip
	If mode == 1
		akTarget.unequipall() ;remove all gear
	ElseIf mode == 2 ;This trick triggers NPC equip event and force reequiping his outfit.
		_SMF_API SMF = GetAPI()
		if SMF == none
			RaiseSMFAPIError()
			return None
		endif
		Armor JewelryRingGold = SMF.JewelryRingGold
		akTarget.additem(JewelryRingGold,1,true) 
		akTarget.equipitem(JewelryRingGold,false,true)
		akTarget.removeitem(jewelryringgold,1,true)
	EndIf
EndFunction