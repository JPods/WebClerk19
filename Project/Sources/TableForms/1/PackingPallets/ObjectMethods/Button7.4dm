C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aShipSel)
CONFIRM:C162("Remove "+String:C10($k)+" Packages/Pallets/Containers from Superior Packing Level?")
If (OK=1)
	ARRAY LONGINT:C221($aChangedPallets; 0)
	ARRAY LONGINT:C221($aShipSelTemp; 0)
	COPY ARRAY:C226(aShipSel; $aShipSelTemp)
	For ($i; $k; 1; -1)  //For ($k;1;1;-1)
		$w:=Find in array:C230($aChangedPallets; aPKUniqueIDSuperior{$aShipSelTemp{$i}})
		If ($w<1)
			INSERT IN ARRAY:C227($aChangedPallets; 1; 1)
			$aChangedPallets{1}:=aPKUniqueIDSuperior{$aShipSelTemp{$i}}
		End if 
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{$aShipSelTemp{$i}})
		If (Not:C34(Locked:C147([LoadTag:88])))
			If ([LoadTag:88]ideSuperior:27>0)
				[LoadTag:88]ideSuperior:27:=0
				SAVE RECORD:C53([LoadTag:88])
				UNLOAD RECORD:C212([LoadTag:88])
				aPKUniqueIDSuperior{$aShipSelTemp{$i}}:=0
			End if 
			//PKArrayManage (-1;$aShipSelTemp{$i};1)//manage pallet record
		Else 
			ALERT:C41("[LoadTag]UniqueID "+String:C10([LoadTag:88]idNum:1)+" is locked.")
		End if 
	End for 
	//
	$k:=Size of array:C274($aChangedPallets)
	For ($i; 1; $k)
		$curUniqueID:=$aChangedPallets{$i}
		PKPalletWeightReCalc($curUniqueID)
		$w:=Find in array:C230(aPKUniqueID22; $curUniqueID)
		If ($w>0)
			aPKWeightExtended22{$w}:=[LoadTag:88]weightExtended:2
		End if 
		UNLOAD RECORD:C212([LoadTag:88])
	End for 
	
	//
	//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
End if 