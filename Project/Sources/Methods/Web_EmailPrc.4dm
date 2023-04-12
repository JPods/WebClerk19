//%attributes = {"publishedWeb":true}
//KeyModifierCurrent
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Email Harvest")

If ($found>0)
	BRING TO FRONT:C326($found)
Else 
	<>processAlt:=New process:C317("Web_EmialHvWind"; <>tcPrsMemory; "Email Harvest")
End if 