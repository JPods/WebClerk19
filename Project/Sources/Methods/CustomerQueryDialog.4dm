//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/18, 06:08:09
// ----------------------------------------------------
// Method: CustomerQueryDialog
// Description
// was  FindCustArray
//
// Parameters
// ----------------------------------------------------
//ProcessTableOpen(Table(->[Customer]); "reduce selection([Customer];0)"; "")
//If (False)
C_POINTER:C301($1; $2; $ptTable; ptCurTable)
C_POINTER:C301(ptCurTable)
C_TEXT:C284($setName)
C_LONGINT:C283(vHere)

If (Count parameters:C259<2)
	If (vHere>1)
		CANCEL:C270
	End if 
	ARRAY LONGINT:C221(aiRecordNums; 0)
	$ptTable:=(->[Customer:2])
	<>prcControl:=1
	//If (<>WriteHere)
	SELECTION TO ARRAY:C260($ptTable->; aiRecordNums)
	<>processAlt:=New process:C317("CustomerQueryDialog"; <>tcPrsMemory; "Query: "+Table name:C256($ptTable); $ptTable; ->aiRecordNums)
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 20)
	Until (<>prcControl=0)
	ARRAY LONGINT:C221(aiRecordNums; 0)
Else 
	ptCurTable:=$1
	ARRAY LONGINT:C221(aiRecordNums; 0)
	COPY ARRAY:C226($2->; aiRecordNums)
	<>prcControl:=0
	Process_InitLocal
	vHere:=0
	$setName:="set"+Table name:C256($1)
	CREATE SET FROM ARRAY:C641(ptCurTable->; aiRecordNums; $setName)
	USE SET:C118($setName)
	CLEAR SET:C117($setName)
	jCenterWindow(700; 580; 1)
	DIALOG:C40([Customer:2]; "diaFindCustomer")
	CLOSE WINDOW:C154
	If (myOK=2)
		ProcessTableOpen(Table:C252(->[Customer:2]); ""; "")
	End if 
End if 
//End if 
