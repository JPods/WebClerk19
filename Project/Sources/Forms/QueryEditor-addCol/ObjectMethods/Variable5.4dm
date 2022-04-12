KeyModifierCurrent
If (CmdKey=0)
	If (vText1="")
		Srch_BuildSyntax
	End if 
	ExecuteText(0; vText1)
Else 
	QUERY:C277(Table:C252(curTableNum)->)
End if 
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
myOK:=1