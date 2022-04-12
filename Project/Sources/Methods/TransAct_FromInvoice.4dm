//%attributes = {"publishedWeb":true}
//Method: TransAct_FromInvoice
<>ptCurTable:=ptCurTable
TRACE:C157
If (vHere=2)
	CREATE EMPTY SET:C140(<>ptCurTable->; "<>curSelSet")
	ADD TO SET:C119(<>ptCurTable->; "<>curSelSet")
Else 
	COPY SET:C600("UserSet"; "<>curSelSet")
End if 
<>prcControl:=1
C_TEXT:C284($theName)
<>processAlt:=New process:C317("TransAct_TunnelTo"; <>tcPrsMemory; Table name:C256(<>ptCurTable))
