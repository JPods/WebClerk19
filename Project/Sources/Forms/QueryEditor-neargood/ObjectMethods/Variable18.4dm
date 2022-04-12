KeyModifierCurrent
If (CmdKey=0)
	If (vText1="")
		Srch_BuildSyntax
	End if 
	C_LONGINT:C283(doQuickQuote)
	If ((doQuickQuote=1) | (ptCurTable=Table:C252(curTableNum)))
		ExecuteText(0; vText1)
		$setName:="<>set"+Table name:C256(curTableNum)
		CLEAR SET:C117($setName)
		CREATE SET:C116(Table:C252(curTableNum)->; $setName)
	Else 
		
		DB_ShowCurrentSelection(Table:C252(curTableNum); vText1; 11; ""; 1)
		CANCEL:C270
	End if 
Else 
	QUERY:C277(Table:C252(curTableNum)->)
End if 
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
myOK:=1