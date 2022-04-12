//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: PkScaleStart
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Scales")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
	
Else 
	C_LONGINT:C283(<>processScale)
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processScale:=New process:C317("PkScaleProcess"; <>tcPrsMemory; "Scales")
End if 