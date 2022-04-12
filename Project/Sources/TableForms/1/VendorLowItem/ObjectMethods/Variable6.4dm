If (Size of array:C274(aLwItmLines)>0)
	myCycle:=12  //to load items
	If (Size of array:C274(aLwVndLines)>0)
		myOK:=1  //to load vendor
		GOTO RECORD:C242([Vendor:38]; aVendRec{aLwVndLines{1}})
	Else 
		myOK:=0
	End if 
	
	REDUCE SELECTION:C351([PO:39]; 0)
	ADD RECORD:C56([PO:39])
	// End if 
Else 
	BEEP:C151
	BEEP:C151
	ALERT:C41("Select one or more items to add to a new PO.")
End if 