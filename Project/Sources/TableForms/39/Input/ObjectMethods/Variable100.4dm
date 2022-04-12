KeyModifierCurrent
If (CmdKey=1)
	TRACE:C157
	Unique_Reset(->[PO:39]; ->[PO:39]poNum:5; ->srPo)
Else 
	
	// Modified by: Bill James (2018-06-07T00:00:00)  Simplified new process
	If ((srPO>0) & (booAccept))
		If (Modified record:C314([PO:39]))  //NO CANCEL
			myCycle:=6
			jAcceptButton
		End if 
		$recNum:=Record number:C243([PO:39])
	Else 
		BEEP:C151
		BEEP:C151
	End if 
	
	C_TEXT:C284($theScript)
	$theScript:="QUERY([PO];[PO]PONum="+String:C10(srPO)+")"
	ProcessTableOpen(Table:C252(->[PO:39]); $theScript; "")
	If (OptKey=1)
		CANCEL:C270  // close process
	End if 
	
End if 
srPO:=[PO:39]poNum:5