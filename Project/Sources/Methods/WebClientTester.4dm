//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/05/09, 06:54:07
// ----------------------------------------------------
// Method: WebClientTester
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Count parameters:C259=0)
	C_LONGINT:C283($found)
	$found:=Prs_CheckRunnin("WebClientTester")
	If ($found>0)
		If (Frontmost process:C327#<>aPrsNum{$found})
			BRING TO FRONT:C326(<>aPrsNum{$found})
		End if 
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("WebClientTester"; 0; "WebClientTester"; [SyncRelation:103]name:8)
	End if 
Else 
	C_TEXT:C284($1)
	READ ONLY:C145([SyncRelation:103])
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8=$1)
	
	FORM SET INPUT:C55([Control:1]; "ClientTester")
	ptCurTable:=(->[Control:1])
	// calSupport:=File([Service])//to be used for mixing calanders between files
	ProcessTableOpen(->[Control:1]; "skip")
	DELAY PROCESS:C323(Current process:C322; 30)
	POST OUTSIDE CALL:C329(<>theProcessList)
End if 



