//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TxtReplaceWindow
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 

//Procedure: Srch_FullDia
curTableNum:=Table:C252(ptCurTable)
curTableNumAlt:=curTableNum
jCenterWindow(500; 370; -724)
DIALOG:C40([Item:4]; "ReplaceString")
CLOSE WINDOW:C154
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)