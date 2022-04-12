//%attributes = {"publishedWeb":true}
//Procedure: File_dSelection([File])
C_LONGINT:C283(bSearch; bSort)
C_POINTER:C301($1; $2)
myOK:=0
KeyModifierCurrent
If (Count parameters:C259=1)
	curTableNum:=Table:C252($1)
End if 
Case of 
	: (ShftKey=1)
		QUERY:C277(Table:C252(curTableNum)->)
		myOK:=OK
	: (OptKey=1)
		Show_RecordNumber(-1; curTableNum)
		CANCEL:C270
		<>prcControl:=1
		ProcessTableOpen(curTableNum)
	Else 
		Srch_FullDia(Table:C252(curTableNum))
End case 
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)

If (viRecordsInSelection>0)
	myOK:=1
End if 

//
If ((ptCurTable#(Table:C252(curTableNum))) & (vHere=0))
	jsetDefaultFile(Table:C252(curTableNum))
End if 