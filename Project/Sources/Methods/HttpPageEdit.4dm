//%attributes = {"publishedWeb":true}
//Procedure: HttpPageEdit
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Web Site Edit")
//
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("HttpEditWin"; <>tcPrsMemory; "Web Site Edit")
End if 