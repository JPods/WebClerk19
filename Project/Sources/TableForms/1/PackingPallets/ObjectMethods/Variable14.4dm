ALERT:C41("Pending")
If (False:C215)
	If (Size of array:C274(aPalletSel)>0)
		QUERY:C277([UserReport:46]; [UserReport:46]Name:2="PKPrinting")
		If (Records in selection:C76([UserReport:46])=1)
			C_LONGINT:C283($incRec; $cntRec)
			$cntRec:=Size of array:C274(aPalletSel)
			
			For ($incRec; 1; $cntRec)
				QUERY:C277([LoadTag:88]; [LoadTag:88]idUnique:1=aPKUniqueID22{aPalletSel{$incRec}})
				$err:=0
				//KeyModifierCurrent 
				If ([LoadTag:88]ContainerType:26>1)
					//PKPrintingArrays ("InPallet")
				Else 
					//PKPrintingArrays ("InBox")
				End if 
				COPY ARRAY:C226(aPrintRecNums; aPrntRecs)  //needed for report body iteration
			End for 
			Prnt_ReportOpts
			UNLOAD RECORD:C212([UserReport:46])
		Else 
			
			ALERT:C41("You need a UserReport Named 'PKPrinting'")
		End if 
	End if 
End if 