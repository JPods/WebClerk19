// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:59:05
// ----------------------------------------------------
// Method: Object Method: b3
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Close Button Pallet Window

TRACE:C157

C_LONGINT:C283($i; $k; $curUniqueID)  //###_jwm_###
$k:=Size of array:C274(aPalletSel)
CONFIRM:C162("Mark complete "+String:C10($k)+" Pallets/containers?")
If (OK=1)
	For ($i; 1; $k)
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID22{aPalletSel{$i}})
		[LoadTag:88]complete:36:=2
		[LoadTag:88]status:6:="Closed"  //###_jwm_###
		aPKStatus22{aPalletSel{$i}}:="Closed"  //###_jwm_###
		If ([LoadTag:88]dtShipOn:10#0)
			CONFIRM:C162("Set Date Shipped")
			If (ok=1)
				[LoadTag:88]dtShipOn:10:=DateTime_DTTo
			End if 
		Else 
			[LoadTag:88]dtShipOn:10:=DateTime_DTTo
		End if 
		$curUniqueID:=[LoadTag:88]idNum:1  //###_jwm_###
		PKPalletWeightReCalc($curUniqueID)
		SAVE RECORD:C53([LoadTag:88])
		UNLOAD RECORD:C212([LoadTag:88])
	End for 
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
	
End if 