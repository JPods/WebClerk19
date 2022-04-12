C_LONGINT:C283($i; $k; $curRecordID)
$k:=Size of array:C274(aPalletSel)
If ($k>0)
	CONFIRM:C162("Delete selected Pallets/containers; "+String:C10($k)+"?")
	If (OK=1)
		For ($i; 1; $k)
			$curRecordID:=aPKUniqueID22{aPalletSel{$i}}
			QUERY:C277([LoadTag:88]; [LoadTag:88]ideSuperior:27=aPKUniqueID22{aPalletSel{$i}})
			$cntPackages:=Records in selection:C76([LoadTag:88])
			For ($incPackages; 1; $cntPackages)
				[LoadTag:88]ideSuperior:27:=0
				SAVE RECORD:C53([LoadTag:88])
			End for 
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID22{aPalletSel{$i}})
			DELETE RECORD:C58([LoadTag:88])
			UNLOAD RECORD:C212([LoadTag:88])
		End for 
	End if 
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
End if 