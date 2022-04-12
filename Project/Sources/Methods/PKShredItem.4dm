//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:05:42
// ----------------------------------------------------
// Method: PKShredItem
// Description
// 
//
// Parameters
// ----------------------------------------------------

KeyModifierCurrent
If (CapKey=1)
	TRACE:C157
End if 
OBJECT SET ENABLED:C1123(b3; False:C215)
<>pkScaleComment:=""  //clear any existing error message
C_LONGINT:C283($w; $i; $k)
$k:=Size of array:C274(aLiLoadItemSelect)
If ($k>0)
	
	$w:=Find in array:C230(aoUniqueID; aLiLineID{aLiLoadItemSelect{1}})
	$wPack:=aLiLoadItemSelect{1}
	If ($w<1)
		BEEP:C151
		BEEP:C151
	Else 
		ARRAY LONGINT:C221(aoLnSelect; 1)
		aoLnSelect{1}:=$w
		If ((viScanByAction<2) & (aOQtyPack{$w}>1))  //add by scan count
			aOQtyBL{$w}:=aOQtyBL{$w}+1
			aOQtyPack{$w}:=aOQtyPack{$w}-1
			iLoReal4:=Round:C94(aOQtyPack{$w}*aOUnitWt{$w}; viWtPrecision)
			aLiQty{$wPack}:=aLiQty{$wPack}-1
			aLiExtendedWt{$wPack}:=Round:C94(aLiUnitWt{$wPack}*aLiQty{$wPack}; viWtPrecision)
			vlLineUniqueID:=aLiLineID{$wPack}
			iLoReal2:=aLiExtendedWt{$wPack}
			iLoReal1:=aLiQty{$wPack}
		Else 
			aOQtyBL{$w}:=aOQtyBL{$w}+aOQtyPack{$w}
			aOQtyPack{$w}:=0
			LT_FillArrayLoadItems(-1; aLiLoadItemSelect{1}; 1)
		End if 
	End if 
	
	
	
	ARRAY LONGINT:C221(aoLnSelect; 1)
	aoLnSelect{1}:=$w
	viVert:=$w
	
	//  CHOPPED  $error:=AL_GetSelect(eLoadList; aoLnSelect)
	//  CHOPPED  AL_GetScroll(eLoadList; viVert; viHorz)
	//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
	// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
	// -- AL_SetScroll(eLoadList; viVert; viHorz)
	
	//  CHOPPED  $error:=AL_GetSelect(eOrdList; aoLnSelect)
	//  CHOPPED  AL_GetScroll(eOrdList; viVert; viHorz)
	//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
	// -- AL_SetSelect(eOrdList; aoLnSelect)
	// -- AL_SetScroll(eOrdList; viVert; viHorz)
	PKSetColor(eOrdList; ->aOItemNum)  //###_jwm_###
	
Else 
	ALERT:C41("Select an pack item line first.")
End if 