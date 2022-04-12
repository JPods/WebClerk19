//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Try_OpenVendorShipWindow
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("VendorInvoices")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("Try_AdjWinWB"; <>tcPrsMemory; "VendorInvoices")
	
End if 