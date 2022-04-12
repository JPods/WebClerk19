//%attributes = {"publishedWeb":true}
//Procedure: Web_Setup
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("WebClerk")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("WebSet_OpenWind"; <>tcPrsMemory; "WebClerk")
End if 
