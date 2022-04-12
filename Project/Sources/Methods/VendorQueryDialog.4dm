//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/18, 10:39:39
// ----------------------------------------------------
// Method: VendorQueryDialog
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20190226_1003 changed to Plain Form window

C_POINTER:C301(ptCurTable)
C_TEXT:C284($setName)

If (Count parameters:C259<2)
	If (vHere>1)
		CANCEL:C270
	End if 
	ARRAY LONGINT:C221(aiRecordNums; 0)
	$ptTable:=(->[Vendor:38])
	<>prcControl:=1
	//If (<>WriteHere)
	SELECTION TO ARRAY:C260($ptTable->; aiRecordNums)
	<>processAlt:=New process:C317("VendorQueryDialog"; <>tcPrsMemory; "Query: "+Table name:C256($ptTable); $ptTable; ->aiRecordNums)
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
	//jCenterWindow (700;580;1)
	$winid:=Open form window:C675([Vendor:38]; "diaFindVendor"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([Vendor:38]; "diaFindVendor")
	CLOSE WINDOW:C154
	
	If (myOK=2)
		ProcessTableOpen(Table:C252(->[Vendor:38]); ""; "")
	End if 
End if 
