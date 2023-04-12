
// Modified by: Bill James (2022-05-29T05:00:00Z)
// Method: cLine
// Description 
// Parameters
// ----------------------------------------------------

Class constructor($dataClassName : Text; $item_o : Object; $process_o : Object)
	This:C1470.dataClassName:=$dataClassName
	This:C1470.idParent:=$idParent
	var $c : Collection
	var $o : Object
	var $name : Text
	
	var $oEntity : Object
	$oEntity:=ds:C1482[$dataClassName].new()
	For each ($name; $oEntity)
		This:C1470[$name]:=$oEntity[$name]
	End for each 
	
	This:C1470.itemNum:=$item_o.itemNum
	If (False:C215)
		If (($process_o.alerts.alertDialog) & ($item_o.alertMessage#""))
			ALERT:C41($item_o.itemNum+": "+$item_o.alertMessage)
		End if 
		If (($process_o.alerts.console) & ($item_o.alertMessage#""))
			ConsoleLog($item_o.itemNum+": "+$item_o.alertMessage)
		End if 
	End if 
	This:C1470.qty:=$item_o.qtySaleDefault
	This:C1470.taxJuris:=$item_o.taxID
	This:C1470.description:=$item_o.description
	This:C1470.itemNumAlt:=$item_o.mfrItemNum
	This:C1470.printNot:=$item_o.printNot
	This:C1470.taxJuris:=$item_o.taxID
	// catalogs
	This:C1470.unitPrice:=$item_o.priceA
	This:C1470.discount:=0
	This:C1470.unitCost:=$item_o.costMSC
	This:C1470.unitofMeasure:=$item_o.unitOfMeasure
	This:C1470.serial_o:=New object:C1471
	This:C1470.item_o:=New object:C1471("id"; $item_o.id; "details"; $item_o.descriptionDetail)
	
	// discounts
	$thePrec:=2
	Case of 
		: (This:C1470.dataClassName="OrderLine")
			This:C1470.discountedPrice:=Round:C94(This:C1470.unitPrice*(1-(0.01*This:C1470.discount)); $thePrec)
			This:C1470.extendedPrice:=This:C1470.qty*This:C1470.discountedPrice
			This:C1470.extendedCost:=This:C1470.qty*This:C1470.unitCost
			This:C1470.extendedWt:=This:C1470.qty*This:C1470.unitWt
			This:C1470.qtyBackLogged:=This:C1470.qty-This:C1470.qtyShipped
			
			
		: (This:C1470.dataClassName="InvoiceLine")
			
			
		: (This:C1470.dataClassName="ProposalLine")
			
			
		: (This:C1470.dataClassName="POLine")
			
	End case 
	
Function calc($dataClassName : Text; $o : Object)
	
	
	Case of 
		: (This:C1470.dataClassName="OrderLine")
			var $thePrec : Integer
			$thePrec:=2
			$o.discountedPrice:=Round:C94($o.unitPrice*(1-(0.01*$o.discount)); $thePrec)
			$o.extendedPrice:=$o.qty*$o.discountedPrice
			$o.extendedCost:=$o.qty*$o.unitCost
			$o.extendedWt:=$o.qty*$o.unitWt
			$o.qtyBackLogged:=$o.qty-$o.qtyShipped
			
			
		: (This:C1470.dataClassName="InvoiceLine")
			
			
		: (This:C1470.dataClassName="ProposalLine")
			
			
		: (This:C1470.dataClassName="POLine")
			
	End case 
	
Function setRecord($record_o)->$result : Collection
	var $result : Collection
	$dataClassName:=$record_o.getInfo().tableName
	For each ($name; $record_o)
		$result.push(New object:C1471($name; $record_o[$name]))
	End for each 