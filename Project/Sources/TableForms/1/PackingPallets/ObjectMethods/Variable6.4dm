TRACE:C157
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aPalletSel)
CONFIRM:C162("Assign Pallet Weight "+String:C10(iLoReal1)+"?")
If (OK=1)
	For ($i; 1; $k)
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID22{aPalletSel{$i}})
		[LoadTag:88]weightPalletContainer:35:=iLoReal1
		SAVE RECORD:C53([LoadTag:88])
		PKPalletWeightReCalc(aPKUniqueID22{aPalletSel{$i}})
		aPKWeightPallet22{aPalletSel{$i}}:=[LoadTag:88]weightPalletContainer:35
		aPKWeightExtended22{aPalletSel{$i}}:=[LoadTag:88]weightExtended:2
		UNLOAD RECORD:C212([LoadTag:88])
	End for 
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
End if 