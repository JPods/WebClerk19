//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/11/20, 14:19:11
// ----------------------------------------------------
// Method: dInventoryCreate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtTable)
C_OBJECT:C1216($2; $voLine)
C_OBJECT:C1216($2; $voEntity)
C_OBJECT:C1216($vodInventory)
$vtTable:=$1
$voLine:=$2
$voEntity:=$3

$vodInventory:=ds:C1482.dInventory.new()

Case of 
	: ($vtTable="OrderLine")
		$vodInventory.qtyOnHand:=0
		$vodInventory.qtyOnSO:=$voLine.qtyOrdered
		$vodInventory.qtyOnPO:=0
		$vodInventory.qtyOnWO:=0
		$vodInventory.qtyOnAdj:=0
		$vodInventory.itemNum:=$voLine.itemNum
		$vodInventory.unitCost:=$voLine.unitCost
		$vodInventory.idNumProject:=$voLine.parentOrder.idNumProject
		$vodInventory.docid:=$voEntity.orderNum
		$vodInventory.idNumLine:=$voLine.idNum
		$vodInventory.receiptid:=0
		$vodInventory.custVendID:=$voEntity.customerID
		$vodInventory.Reason:="oi new line"
		$vodInventory.typeID:="SO"
		$vodInventory.dtCreated:=DateTime_DTTo
		$vodInventory.dateCreated:=Current date:C33
		$vodInventory.timeCreated:=Current time:C178
		$vodInventory.note:=""
		$vodInventory.takeAction:=1
		$vodInventory.siteID:=$voEntity.siteID
		$vodInventory.unitPrice:=DiscountApply($voLine.unitPrice; $voLine.discount; <>tcDecimalUP)
		$vodInventory.changedBy:=Current user:C182
		$vodInventory.division:=""
		$vodInventory.tableNum:=Table:C252(->[Order:3])
		
	: ($vtTable="InvoiceLine")
		
		
	: ($vtTable="ProposalLine")
		
		
	: ($vtTable="WorkOrder")
		
End case 

$vodInventory.save()