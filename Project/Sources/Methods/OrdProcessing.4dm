//%attributes = {"publishedWeb":true}
//Procedure: OrdProcessing
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("OrderProduction")
If ($found>0)
	BRING TO FRONT:C326($found)
	
Else 
	C_POINTER:C301(ptCurTable)
	If (Is nil pointer:C315(ptCurTable))
		<>ptCurTable:=(->[Control:1])
	Else 
		<>ptCurTable:=ptCurTable
	End if 
	<>prcControl:=1
	<>processAlt:=New process:C317("Ord_ProdWin"; <>tcPrsMemory; "OrderProduction")
End if 