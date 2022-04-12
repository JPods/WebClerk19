//%attributes = {}

// Modified by: Bill James (2022-01-16T06:00:00Z)
// Method: DBItem_Init
// Description
// Parameters
// ----------------------------------------------------

var $0; $1; $o; $rec_o; $test_o; $act_o : Object
var $2; $3; $itemNum; $typeID; $suffix : Text
var $4; $5; $bundleQty; $qtySale : Real
$bundleQty:=1
$qtySale:=1
$typeID:=""
$rec_o:=ds:C1482.Item.new()
$o:=$1
$suffix:=""

If ($o.suffix#Null:C1517)
	If ($o.suffix#"")
		$suffix:="-"+$o.suffix
	End if 
End if 
If ($o.itemNum=Null:C1517)
	Repeat 
		$itemNum:=String:C10(CounterNew(->[Item:4]))+$suffix
		$test_o:=ds:C1482.Item.query("itemNum = :1"; $itemNum)
	Until ($test_o=Null:C1517)
Else 
	If ($o.itemNum#"")
		$itemNum:=$o.itemNum+$suffix
	End if 
End if 
If ($itemNum#"")
	$test_o:=ds:C1482.Item.query("itemNum = :1"; $itemNum)
End if 

If ($test_o#Null:C1517)
	// $1.newRecord:="error: Existing"
	$0:=Null:C1517
Else 
	If ($o.qtySaleDefault#Null:C1517)
		$rec_o.qtySaleDefault:=$o.qtySaleDefault
	Else 
		$rec_o.qtySaleDefault:=1
	End if 
	If ($o.qtySaleDefault#Null:C1517)
		$rec_o.barCode:=$o.barCode
	Else 
		$rec_o.barCode:=$rec_o.itemNum
	End if 
	$rec_o.tallyByType:=True:C214
	$rec_o.commissionA:=100
	$rec_o.commissionB:=100
	$rec_o.commissionC:=100
	$rec_o.commissionD:=100
	$rec_o.discountable:=True:C214
	$rec_o.taxID:="tax"
	$rec_o.printNot:=1
	
	If ($o.description#"")
		$rec_o.description:=$o.description
	Else 
		$rec_o.description:="Enter a Description"  // ### jwm ### 20171219_1537
	End if 
	
	
	$rec_o.glSales:=Storage:C1525.gl.glSales
	$rec_o.glCost:=Storage:C1525.gl.glCost
	$rec_o.glInventory:=Storage:C1525.gl.glInventory
	
	If ($o.type#Null:C1517)
		If ($o.type#"")
			$act_o:=ds:C1482.GLAccount.query("typeAccount = :1 | typeAccount = :2 & typeItem = :3"; \
				"Inco@"; "Rev@"; $o.type)
			If ($act_o#Null:C1517)
				$rec_o.glSales:=$act_o.account
			End if 
			$act_o:=ds:C1482.GLAccount.query("typeAccount = :1 | typeAccount = :2 | typeAccount = :3 & typeItem = :4"; \
				"Cost@"; "CoG@"; "Exp@"; $o.type)
			If ($act_o#Null:C1517)
				$rec_o.glCost:=$act_o.account
			End if 
			$act_o:=ds:C1482.GLAccount.query("typeAccount = :1 | typeAccount = :2 & typeItem = :3"; \
				"Current ass@"; "Ass@"; $o.type)
			If ($act_o#Null:C1517)
				$rec_o.glInventory:=$act_o.account
			End if 
		End if 
	End if 
	
	OBJECT SET ENTERABLE:C238($rec_o.itemNum; True:C214)
	OBJECT SET ENTERABLE:C238($rec_o.costAverage; True:C214)
	OBJECT SET ENTERABLE:C238($rec_o.barCode; True:C214)
	OBJECT SET ENTERABLE:C238($rec_o.qtyOnHand; True:C214)
	
	$0:=$rec_o
End if 