//%attributes = {"publishedWeb":true}
//Procedure: QuoteQuick 
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Requisitions")
If ($found>0)
	BRING TO FRONT:C326($found)
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("Rq_Window"; <>tcPrsMemory; "Requisitions")
End if 