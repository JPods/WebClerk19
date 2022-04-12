//%attributes = {"publishedWeb":true}
//Procedure: Editor_Linx
C_LONGINT:C283($found)
$doChange:=(UserInPassWordGroup("UnlockRecord"))
If ($doChange)
	$found:=Prs_CheckRunnin("LinxEditor")
	//
	If ($found>0)
		If (Frontmost process:C327#<>aPrsNum{$found})
			BRING TO FRONT:C326(<>aPrsNum{$found})
		End if 
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("Ed_LinxOpenWin"; <>tcPrsMemory; "LinxEditor")
	End if 
Else 
	ALERT:C41("Access denied.")
End if 