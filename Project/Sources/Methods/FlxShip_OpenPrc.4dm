//%attributes = {"publishedWeb":true}
//Procedure: FlxShip_OpenPrc
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("FlexShip")
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("FlxShip_OpenWin"; <>tcPrsMemory; "FlexShip")
End if 