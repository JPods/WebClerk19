//%attributes = {"publishedWeb":true}
If (<>aScripts>1)
	C_LONGINT:C283($found)
	$found:=Prs_CheckRunnin("Scripts")
	If ($found>0)
		If (Frontmost process:C327#<>aPrsNum{$found})
			BRING TO FRONT:C326(<>aPrsNum{$found})
		End if 
	Else 
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("Script_Launch"; <>tcPrsMemory; "Scripts")
	End if 
End if 
