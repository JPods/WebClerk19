//%attributes = {"publishedWeb":true}
//KeyModifierCurrent
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Email Harvest")
//
<>ptCurTable:=(->[Lead:48])

If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>processAlt:=New process:C317("Web_EmialHvWind"; <>tcPrsMemory; "Email Harvest")
End if 