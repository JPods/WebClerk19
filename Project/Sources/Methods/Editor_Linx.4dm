//%attributes = {"publishedWeb":true}
//Procedure: Editor_Linx
C_LONGINT:C283($found)
$doChange:=(UserInPassWordGroup("UnlockRecord"))
If ($doChange)
	$found:=Prs_CheckRunnin("LinxEditor")
	//
	If ($found>0)
		BRING TO FRONT:C326($found)
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("Ed_LinxOpenWin"; <>tcPrsMemory; "LinxEditor")
	End if 
Else 
	ALERT:C41("Access denied.")
End if 