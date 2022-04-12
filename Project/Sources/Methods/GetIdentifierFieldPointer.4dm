//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_prf_v310
	TCStrong_prf_v312
	//04/13/04.prf
	//Added more tables
End if 

C_POINTER:C301($1; $pTable; $0; $pKeyField)
$pTable:=$1

Case of 
		
	: ($pTable=(->[Customer:2]))
		$pKeyField:=->[Customer:2]customerID:1  //A10
		
	: ($pTable=(->[Order:3]))
		$pKeyField:=->[Order:3]orderNum:2  //Longint
		
	: ($pTable=(->[Invoice:26]))
		$pKeyField:=->[Invoice:26]invoiceNum:2  //Longint
		
	: ($pTable=(->[PO:39]))
		$pKeyField:=->[PO:39]poNum:5  //Longint
		
	: ($pTable=(->[Proposal:42]))
		$pKeyField:=->[Proposal:42]proposalNum:5  //Longint
		
	: ($pTable=(->[Contact:13]))
		$pKeyField:=->[Contact:13]customerID:1  //A10
		
	: ($pTable=(->[Employee:19]))
		$pKeyField:=->[Employee:19]nameid:1  //A25
		
	: ($pTable=(->[Lead:48]))
		$pKeyField:=->[Lead:48]idNum:32  //Longint
		
	: ($pTable=(->[Letter:20]))
		$pKeyField:=->[Letter:20]name:1  //A20
		
	: ($pTable=(->[Vendor:38]))
		$pKeyField:=->[Vendor:38]vendorID:1  //A10
		
		
	: ($pTable=(->[Payment:28]))  //04/13/04.prf
		$pKeyField:=->[Payment:28]idNum:8  //Longint
		
	: ($pTable=(->[InventoryStack:29]))  //04/13/04.prf
		$pKeyField:=->[InventoryStack:29]idNum:1  //Longint
		
	: ($pTable=(->[Ledger:30]))  //04/13/04.prf
		$pKeyField:=->[Ledger:30]idNum:2  //Longint
		
	: ($pTable=(->[ProposalLine:43]))  //04/13/04.prf
		$pKeyField:=->[ProposalLine:43]proposalNum:1  //Longint
		
	: ($pTable=(->[OrderLine:49]))  //04/13/04.prf
		$pKeyField:=->[OrderLine:49]orderNum:1  //Longint
		
	: ($pTable=(->[InvoiceLine:54]))  //04/13/04.prf
		$pKeyField:=->[InvoiceLine:54]invoiceNum:1  //Longint
		
	: ($pTable=(->[WorkOrder:66]))  //04/13/04.prf
		$pKeyField:=->[WorkOrder:66]invoiceNum:1  //Longint
		
	: ($pTable=(->[QA:70]))  //04/13/04.prf
		$pKeyField:=->[QA:70]customerID:1  //A10
		
	Else 
		//Nil pointer returned in this case!
		$pKeyField:=<>cptNilPoint
End case 

$0:=$pKeyField