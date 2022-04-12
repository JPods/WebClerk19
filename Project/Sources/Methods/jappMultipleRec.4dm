//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/20/18, 13:53:10
// ----------------------------------------------------
// Method: jappMultipleRec
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20180720_1353 updated progress

C_LONGINT:C283($i; $k)
//ON EVENT CALL("jotcCmdQAction")

$k:=Records in selection:C76(Table:C252(curTableNum)->)
FIRST RECORD:C50(Table:C252(curTableNum)->)
//ThermoInitExit (("Change records:  "+Table name(curTableNum));$k;True)
$viProgressID:=Progress New
For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Change records:")
	If (<>ThermoAbort)
		$i:=$k
	Else 
		jimportSaveRay
		NEXT RECORD:C51(Table:C252(curTableNum)->)
	End if 
End for 
//Thermo_Close 
Progress QUIT($viProgressID)
//ON EVENT CALL("")