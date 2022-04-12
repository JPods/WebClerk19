//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/14/07, 01:10:30
// ----------------------------------------------------
// Method: Method: Prs_UpdatePrsWindow
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	C_LONGINT:C283($found)
	C_LONGINT:C283($1)
	$found:=Prs_CheckRunnin("@"+Table name:C256($1)+"@")
	If ($found>0)
		<>prsTableNum:=$1
		<>prsRecNum:=Record number:C243(Table:C252($1)->)
		UNLOAD RECORD:C212(Table:C252($1)->)
		POST OUTSIDE CALL:C329(<>aPrsNum{$found})
	Else 
		ProcessTableOpen(Table:C252(->[CallReport:34])*-1)
	End if 
End if 