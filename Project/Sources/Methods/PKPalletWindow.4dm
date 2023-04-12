//%attributes = {"publishedWeb":true}
//Procedure: PKPalletWindow
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("PalletsContainers")
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("PackingPalletWin"; <>tcPrsMemory; "PalletsContainers")
End if 