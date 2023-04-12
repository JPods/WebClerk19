//%attributes = {"publishedWeb":true}
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Recent Buys")
If ($found>0)
	BRING TO FRONT:C326($found)
	<>CustAcct:=[Customer:2]customerID:1
	
Else 
	<>ptCurTable:=(->[Customer:2])
	<>prcControl:=1
	C_TEXT:C284(<>CustAcct)
	<>CustAcct:=[Customer:2]customerID:1
	<>processAlt:=New process:C317("Tel_RecentBuys"; <>tcPrsMemory; "Recent Buys")
End if 