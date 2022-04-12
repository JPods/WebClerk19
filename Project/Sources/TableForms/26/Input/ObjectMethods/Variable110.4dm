KeyModifierCurrent
If (CmdKey=1)
	Unique_Reset(->[Invoice:26]; ->[Invoice:26]invoiceNum:2; ->srIv)
Else 
	If ((srIv>0) & (booAccept))
		// Modified by: Bill James (2018-06-07T00:00:00)  Simplified new process
		If (Modified record:C314([Invoice:26]))  //NO CANCEL
			myCycle:=6
			jAcceptButton
		End if 
	Else 
		BEEP:C151
		BEEP:C151
	End if 
	//$recNum:=Record number([Invoice])
	//If (Records in selection([Invoice])=1)
	C_TEXT:C284($theScript)
	$theScript:="QUERY([Invoice];[Invoice]InvoiceNum="+String:C10(srIv)+")"
	ProcessTableOpen(Table:C252(->[Invoice:26]); $theScript; "")
	If (OptKey=1)
		CANCEL:C270  // close process
	End if 
	//Else 
	//GOTO RECORD([Invoice];$recNum)
	
	//Else 
	//PUSH RECORD([Invoice])
	//QUERY([Invoice];[Invoice]InvoiceNum=srIv)
	//If (Records in selection([Invoice])>0)
	//curTableNum:=Table(->[Invoice])
	//ProcessTableOpen 
	//End if 
	//POP RECORD([Invoice])
	
End if 
srIv:=[Invoice:26]invoiceNum:2