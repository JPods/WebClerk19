//%attributes = {"publishedWeb":true}
//KeyModifierCurrent
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Shop")
//
If ($found>0)
	BRING TO FRONT:C326($found)
Else 
	<>processAlt:=New process:C317("TC_ShopLaunch"; <>tcPrsMemory; "Shop")
End if 