// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 15:03:00
// ----------------------------------------------------
// Method: Object Method: bSerialRec
// Description
// TestThis
//
// Parameters
// ----------------------------------------------------

If (Records in selection:C76([ItemSerial:47])>0)
	C_POINTER:C301($ptFile; <>ptCurTable)
	If (Is nil pointer:C315(<>ptCurTable) | (vHere=0))
		<>ptCurTable:=(->[ItemSerial:47])
	End if 
	$ptFile:=<>ptCurTable
	DB_ShowCurrentSelection(<>ptCurTable; ""; 1; "")  //tablePt, script, flowBranch, Title
	myOK:=0
	CANCEL:C270
	ptCurTable:=$ptFile
End if 