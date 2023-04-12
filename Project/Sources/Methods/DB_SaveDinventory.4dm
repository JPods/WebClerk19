//%attributes = {}

// Modified by: Bill James (2022-06-28T05:00:00Z)
// Method: DB_SaveDinventory
// Description 
// Parameters
// ----------------------------------------------------

#DECLARE($dataClassName : Text; $record : Object; $line : Object; $action : Text)
var $doChange : Boolean
var $dQty; $dCost; $dPrice : Real
var $dRec : Object
$doChange:=False:C215
$dRec:=ds:C1482.DInventory.new()
If (entry_o.customerID#Null:C1517)
	$dRec.customerID:=entry_o.customerID
Else 
	If (entry_o.vendorID#Null:C1517)
		$dRec.customerID:=entry_o.vendorID
	Else 
		$dRec.customerID:="adjustment"
	End if 
End if 
$dRec.itemNum:=$record.itemNum
$dRec.tableName:=$dataClassName
$dRec.dtCreated:=DateTime_DTTo
$dRec.dateCreated:=Current date:C33
$dRec.obGeneral:=Init_obGeneral
$dRec.obGeneral.related:=New object:C1471("document"; New object:C1471("id"; ""; "num"; 0); \
"line"; New object:C1471("id"; ""; "num"; 0); \
"project"; New object:C1471("id"; ""; "num"; 0); \
"customer"; New object:C1471("id"; ""; "idCustomer"; ""); \
"vendor"; New object:C1471("id"; ""; "idVendor"; ""); \
"user"; "")
$dRec.obGeneral.price:=New object:C1471("old"; 0; "new"; 0; "change"; 0)
$dRec.obGeneral.cost:=New object:C1471("old"; 0; "new"; 0; "change"; 0)
$dRec.obGeneral.discount:=New object:C1471("old"; 0; "new"; 0; "change"; 0)
If (voState.useName#Null:C1517)  // coming from web
	$dRec.changedBy:=voState.useName
Else 
	$dRec.changedBy:=Current user:C182
End if 
If (entry_o.idNum#Null:C1517)
	$dRec.obGeneral.related.document.id:=entry_o.id
	$dRec.obGeneral.related.document.num:=entry_o.idNum
	$dRec.idNumDoc:=entry_o.idNum
End if 
If ($line.idNum#Null:C1517)  // avoid adjustments
	$dRec.obGeneral.related.line.id:=$record.id
	$dRec.obGeneral.related.line.num:=$record.idNum
End if 
If (entry_o.idNumProject#Null:C1517)
	$dRec.idNumProject:=entry_o.idNumProject
End if 

If ($line.unitPrice#Null:C1517)
	$dRec.unitPrice:=$line.unitPrice
	$dRec.obGeneral.price.old:=$record.unitPrice
	$dRec.obGeneral.price.new:=$line.unitPrice
	$dRec.obGeneral.price.change:=$line.unitPrice-$record.unitPrice
End if 
If ($line.unitCost#Null:C1517)
	$dRec.unitCost:=$line.unitCost
End if 
If ($line.vaTax#Null:C1517)
	$dRec.vaTax:=$line.vaTax
End if 
If (entry_o.siteID#Null:C1517)
	$dRec.siteID:=entry_o.siteID
End if 
If ($action="New line")
	$dRec.reason:="New line"
	Case of 
		: ($dataClassName="OrderLine")
			$doChange:=True:C214
			$dRec.qtyOnSO:=$line.qty
			
		: ($dataClassName="InoiceLine")
			$doChange:=True:C214
			$dRec.qtyOnHand:=-$line.qty
			
		: ($dataClassName="POLine")
			$doChange:=True:C214
			$dRec.qtyOnPo:=$line.qty
			
		: ($dataClassName="InventoryStack")
			$doChange:=True:C214
			//$dRec.idReceipt:=
			//$dRec.nonProdCost
			//$dRec.duties
			//$dRec.qtyOnAdj
			//$dRec.unitCostAfterChange
		: ($dataClassName="Adjustment")
			//$dRec.unitCostAfterChange
			$dRec.qtyOnAdj:=$line.qty
		: ($dataClassName="WorkOrder")
			$dRec.qtyOnWO:=$line.qty
	End case 
Else 
	Case of 
		: ($dataClassName="OrderLine")
			$dRec.qtyOnSO:=$line.qty-$record.qty
			
		: ($dataClassName="InoiceLine")
			$doChange:=True:C214
			$dRec.qtyOnHand:=$line.qty-$record.qty
			
		: ($dataClassName="POLine")
			$dRec.qtyOnPo:=$line.qty-$record.qty
			
		: ($dataClassName="InventoryStack")
			$doChange:=True:C214
			//$dRec.idReceipt:=
			//$dRec.nonProdCost
			//$dRec.duties
			//$dRec.qtyOnAdj
			//$dRec.unitCostAfterChange
			
		: ($dataClassName="Adjustment")
			//$dRec.unitCostAfterChange
			$dRec.qtyOnAdj:=$line.qty
			
		: ($dataClassName="WorkOrder")
			$dRec.qtyOnWO:=$line.qty-$record.qty
			
	End case 
	
End if 
var $status : Object
$status:=$dRec.save()
// $dRec.qtyOHAfterApplied

