KeyModifierCurrent
If (CmdKey=1)
	TRACE:C157
	Unique_Reset(->[Order:3]; ->[Order:3]orderNum:2; ->srSo)
Else 
	If ((srSO>0) & (booAccept))
		//If (vHere=2)
		If (Modified record:C314([Order:3]))  //NO CANCEL
			myCycle:=6
			jAcceptButton
		End if 
		$recNum:=Record number:C243([Order:3])
	Else 
		BEEP:C151
		BEEP:C151
	End if 
	
	// Modified by: Bill James (2018-06-07T00:00:00)  Simplified new process
	C_TEXT:C284($theScript)
	$theScript:="QUERY([Order];[Order]OrderNum="+String:C10(srSO)+")"
	ProcessTableOpen(Table:C252(->[Order:3]); $theScript; "")
	If (OptKey=1)
		CANCEL:C270  // close process
	End if 
	//Else 
	//PUSH RECORD([Order])
	//C_TEXT($theScript)
	//$theScript:="QUERY([Order];[Order]OrderNum="+String(srSO)+")"
	//ProcessTableOpen(table(->[Order]);$theScript;"")
	//POP RECORD([Order])
	//End if 
	//booPreNext:=True
	
	
End if 
srSO:=[Order:3]orderNum:2  // reset to current order