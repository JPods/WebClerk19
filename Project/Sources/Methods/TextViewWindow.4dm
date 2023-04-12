//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/12/09, 12:49:50
// ----------------------------------------------------
// Method: TextViewWindow
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("TextView")
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("TextViewOpen"; <>tcPrsMemory; "TextView")
End if 