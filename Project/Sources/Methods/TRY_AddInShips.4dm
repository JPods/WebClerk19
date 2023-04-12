//%attributes = {"publishedWeb":true}
//Procedure: TRY_AddInShips
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Inship")
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	//<>ptCurFile:=(->[TechNote])   ###_jwm_###
	<>prcControl:=1
	<>processAlt:=New process:C317("TRY_InshipOpenWindow"; <>tcPrsMemory; "Inship")
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 120)
	Until (<>prcControl=0)
End if 
