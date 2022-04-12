//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-07-22T00:00:00, 13:34:08
// ----------------------------------------------------
// Method: TN_Dialog
// Description
// Modified: 07/22/18
// Structure: gkgkgk
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("TechNotes")
If ($found>0)
	CONFIRM:C162("Open another TechNotes Window?"; "Yes"; "No")
End if 
If (($found>0) & (OK=0))
	POST OUTSIDE CALL:C329(<>aPrsNum{$found})
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=(->[TechNote:58])
	<>prcControl:=1
	<>processAlt:=New process:C317("TN_OpenWindow"; <>tcPrsMemory; "TechNotes")
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 120)
	Until (<>prcControl=0)
End if 
