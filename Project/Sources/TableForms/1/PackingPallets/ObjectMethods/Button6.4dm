//UnClose Button Pallet Window

TRACE:C157

C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aPalletSel)
CONFIRM:C162("Mark Pending "+String:C10($k)+" Pallets/containers?")
If (OK=1)
	For ($i; 1; $k)
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID22{aPalletSel{$i}})
		[LoadTag:88]complete:36:=1
		[LoadTag:88]status:6:="Pending"  //###_jwm_###
		aPKStatus22{aPalletSel{$i}}:="Pending"  //###_jwm_###
		//[LoadTag]DTShipOn:=DateTime_Enter 
		//PKPalletWeightReCalc ($curUniqueID)
		SAVE RECORD:C53([LoadTag:88])
		UNLOAD RECORD:C212([LoadTag:88])
	End for 
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
End if 