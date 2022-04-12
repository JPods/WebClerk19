//%attributes = {"publishedWeb":true}
If (False:C215)
	If (False:C215)
		//Method: IEA_ReturnKeyField
		//Date: 01/05/05
		//Who: Bill
		//Description: 
	End if 
	TCMod_606_67_03_04_Trans
End if 

C_POINTER:C301($1)
C_LONGINT:C283($w; $0)
$w:=STR_GetFieldNumber(Table name:C256($1); "idNum")
Case of 
	: ($w>0)
		$0:=$w
	: ($1=(->[Customer:2]))
		$0:=Field:C253(->[Customer:2]customerID:1)
	: ($1=(->[Order:3]))
		$0:=Field:C253(->[Order:3]orderNum:2)
	: ($1=(->[Item:4]))
		$0:=Field:C253(->[Item:4]itemNum:1)
	: ($1=(->[Rep:8]))
		$0:=Field:C253(->[Rep:8]repID:1)
	: ($1=(->[TaxJurisdiction:14]))
		$0:=Field:C253(->[TaxJurisdiction:14]taxJurisdiction:1)
	: ($1=(->[Employee:19]))
		$0:=Field:C253(->[Employee:19]nameID:1)
	: ($1=(->[Invoice:26]))
		$0:=Field:C253(->[Invoice:26]invoiceNum:2)
	: ($1=(->[Term:37]))
		$0:=Field:C253(->[Term:37]termID:1)
	: ($1=(->[Vendor:38]))
		$0:=Field:C253(->[Vendor:38]vendorID:1)
	: ($1=(->[PO:39]))
		$0:=Field:C253(->[PO:39]poNum:5)
	: ($1=(->[Proposal:42]))
		$0:=Field:C253(->[Proposal:42]proposalNum:5)
	: ($1=(->[WorkOrder:66]))
		$0:=Field:C253(->[WorkOrder:66]woNum:29)
	Else 
		$0:=-1
End case 
