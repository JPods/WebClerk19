//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_LONGINT:C283($w)
$w:=STR_GetFieldNumber(Table name:C256($1); "idNum")
Case of 
	: ($w>0)
		$0:=String:C10(Field:C253(Table:C252($1); $w)->)
	: ($1=(->[Customer:2]))
		$0:=[Customer:2]customerID:1
	: ($1=(->[Order:3]))
		$0:=String:C10([Order:3]orderNum:2)
	: ($1=(->[Item:4]))
		$0:=[Item:4]itemNum:1
	: ($1=(->[Rep:8]))
		$0:=[Rep:8]repID:1
	: ($1=(->[TaxJurisdiction:14]))
		$0:=[TaxJurisdiction:14]taxJurisdiction:1
	: ($1=(->[Employee:19]))
		$0:=[Employee:19]nameID:1
	: ($1=(->[Invoice:26]))
		$0:=String:C10([Invoice:26]invoiceNum:2)
	: ($1=(->[Term:37]))
		$0:=[Term:37]termID:1
	: ($1=(->[Vendor:38]))
		$0:=[Vendor:38]vendorID:1
	: ($1=(->[PO:39]))
		$0:=String:C10([PO:39]poNum:5)
	: ($1=(->[Proposal:42]))
		$0:=String:C10([Proposal:42]proposalNum:5)
	: ($1=(->[WorkOrder:66]))
		$0:=String:C10([WorkOrder:66]woNum:29)
End case 
SAVE RECORD:C53($1->)