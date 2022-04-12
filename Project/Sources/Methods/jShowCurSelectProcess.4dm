//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/17/06, 04:08:35
// ----------------------------------------------------
// Method: jShowCurSelectProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	C_LONGINT:C283($viProcess)
	$viProcess:=Current process:C322
	SET MENU BAR:C67(1; $viProcess; *)
	Process_InitLocal
	C_POINTER:C301($ptOrgFile)
	myOK:=0
	$ptOrgFile:=<>ptCurTable
	ptCurTable:=<>ptCurTable
	curTableNum:=Table:C252(ptCurTable)
	
	
	//If (vhere=0)
	<>prcControl:=5
	File_Select("Select the file for which you wish to show records.")
	<>prcControl:=0
	
	If (myOK=1)
		ptCurTable:=Table:C252(curTableNum)
		$setName:="<>set"+Table name:C256(curTableNum)
		USE SET:C118($setName)
		CLEAR SET:C117($setName)
		Prs_DisplaySelected
	End if 
End if 