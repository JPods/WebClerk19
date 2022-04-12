If ((curTableNum=Table:C252(ptCurTable)) | (doQuickQuote=1))
	ALL RECORDS:C47(Table:C252(curTableNum)->)
	viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
	If (doQuickQuote=1)
		CANCEL:C270
	Else 
		myOK:=1
	End if 
Else 
	DB_ShowCurrentSelection(Table:C252(curTableNum); ""; 3; "")
	CANCEL:C270
End if 