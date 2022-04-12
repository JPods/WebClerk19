KeyModifierCurrent
If (OptKey=0)
	If (Size of array:C274(aoLnSelect)>0)
		If (iLoReal3>1)
			iLoReal3:=iLoReal3-1
			iLoReal4:=iLoReal4-aOUnitWt{aoLnSelect{1}}
		Else 
			BEEP:C151
			BEEP:C151
		End if 
	Else 
		ALERT:C41("Select an order line")
	End if 
Else 
	TRACE:C157
	C_LONGINT:C283($w; $i; $k)
	$k:=Size of array:C274(aLiLoadItemSelect)
	If ($k>0)
		$w:=Find in array:C230(aoUniqueID; aLiLineID{aLiLoadItemSelect{1}})
		If ($w<1)
			BEEP:C151
			BEEP:C151
		Else 
			aLiQty{aLiLoadItemSelect{1}}:=aLiQty{aLiLoadItemSelect{1}}-iLoReal3
			aLiExtendedWt{aLiLoadItemSelect{1}}:=Round:C94(aOUnitWt{aLiLoadItemSelect{1}}*aLiQty{aLiLoadItemSelect{1}}; 1)
			//
			aOQtyBL{$w}:=aOQtyBL{$w}+iLoReal3
			aOQtyPack{$w}:=aOQtyPack{$w}-iLoReal3
		End if 
		//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
		ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
		viVert:=aLiLoadItemSelect{1}
		viHorz:=1
		// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
		// -- AL_SetScroll(eLoadList; viVert; viHorz)
		ARRAY LONGINT:C221(aoLnSelect; 1)
		aoLnSelect{1}:=$w
		viVert:=$w
		viHorz:=1
		// -- AL_SetSelect(eOrdList; aoLnSelect)
		// -- AL_SetScroll(eOrdList; viVert; viHorz)
		
		//For ($i;$k;1;-1)
		//$w:=Find in array(aoLnUniqueID;aLiLineID{aLiLoadItemSelect{$i}})
		//If ($w<1)
		//BEEP
		//BEEP
		//Else 
		//aOQtyBL{$w}:=aOQtyBL{$w}+aOQtyPack{$w}
		//aOQtyPack{$w}:=0
		//End if 
		//LT_FillArrayLoadItems (-1;aLiLoadItemSelect{$i};1)
		//End for 
		////  --  CHOPPED  AL_UpdateArrays (eLoadList;-2)
		////  --  CHOPPED  AL_UpdateArrays (eOrdList;-2)
		
	Else 
		ALERT:C41("Select an pack item line first.")
	End if 
End if 