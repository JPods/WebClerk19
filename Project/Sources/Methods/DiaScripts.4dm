//%attributes = {"publishedWeb":true}
If (<>aScripts>1)
	C_LONGINT:C283($found)
	$found:=Prs_CheckRunnin("Scripts")
	If ($found>0)
		BRING TO FRONT:C326($found)
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("Script_Launch"; <>tcPrsMemory; "Scripts")
	End if 
End if 
