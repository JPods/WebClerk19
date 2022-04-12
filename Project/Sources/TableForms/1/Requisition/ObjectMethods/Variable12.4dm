KeyModifierCurrent
REDUCE SELECTION:C351([PO:39]; 0)
TRACE:C157
If (Size of array:C274(aReqSelLns)>0)
	myOK:=0
	Case of 
		: (OptKey=1)
			myOK:=1  //New PO      
		: ((CmdKey=1) & ([PO:39]poNum:5#0))
			myOK:=2  //add to existing PO      
		Else 
			vDiaCom:="Select a new PO"+"\r"+"or enter existing PO#."
			jCenterWindow(194; 196; 1)
			DIALOG:C40([PO:39]; "diaChoosePO")
			CLOSE WINDOW:C154
			vDiaCom:=""
	End case 
	Case of 
		: (myOK=0)
		: (myOK=1)  //new PO
			If (Modified record:C314([Customer:2]))
				SAVE RECORD:C53([Customer:2])
			End if 
			myCycle:=14
			myOK:=0
			REDUCE SELECTION:C351([PO:39]; 0)
			ADD RECORD:C56([PO:39])
		: (myOK=2)  //existing PO      
			myCycle:=15
			myOK:=0
			READ WRITE:C146([PO:39])
			MODIFY RECORD:C57([PO:39])
	End case 
	myCycle:=0
	//myCycle:=14//to load items  
	//REDUCE SELECTION([PO];0)
	//ADD RECORD([PO])
Else 
	BEEP:C151
	BEEP:C151
	ALERT:C41("Select one or more items to add to a new PO.")
End if 