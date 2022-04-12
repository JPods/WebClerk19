KeyModifierCurrent
If (CmdKey=1)
	Unique_Reset(->[Proposal:42]; ->[Proposal:42]proposalNum:5; ->srPp)
Else 
	// Modified by: Bill James (2018-06-07T00:00:00)  Simplified new process
	If ((srPp>0) & (booAccept))
		If (Modified record:C314([Proposal:42]))  //NO CANCEL
			myCycle:=6
			jAcceptButton
		End if 
		$recNum:=Record number:C243([Proposal:42])
	Else 
		BEEP:C151
		BEEP:C151
	End if 
	
	C_TEXT:C284($theScript)
	$theScript:="QUERY([Proposal];[Proposal]ProposalNum="+String:C10(srPp)+")"
	ProcessTableOpen(Table:C252(->[Proposal:42]); $theScript; "")
	If (OptKey=1)
		CANCEL:C270  // close process
	End if 
	
End if 
srPp:=[Proposal:42]proposalNum:5