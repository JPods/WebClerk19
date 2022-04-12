//%attributes = {"publishedWeb":true}
//Procedure: QuoteQuick 
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Requisitions")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("Rq_Window"; <>tcPrsMemory; "Requisitions")
End if 