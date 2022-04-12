TRACE:C157
If (False:C215)
	If (Size of array:C274(aShipSel)>0)
		QUERY:C277([UserReport:46]; [UserReport:46]Name:2="PKPrinting")
		If (Records in selection:C76([UserReport:46])=1)
			
			QUERY:C277([LoadTag:88]; [LoadTag:88]idUnique:1=aPKUniqueID{aShipSel{1}})
			$err:=0
			//KeyModifierCurrent 
			If ([LoadTag:88]ContainerType:26>1)
				//PKPrintingArrays ("InPallet")
			Else 
				//PKPrintingArrays ("InBox")
			End if 
			COPY ARRAY:C226(aPrintRecNums; aPrntRecs)  //needed for report body iteration
			Prnt_ReportOpts
			UNLOAD RECORD:C212([UserReport:46])
		Else 
			
			ALERT:C41("You need a UserReport Named 'PKPrinting'")
		End if 
	End if 
Else 
	ALERT:C41("Pending")
End if 