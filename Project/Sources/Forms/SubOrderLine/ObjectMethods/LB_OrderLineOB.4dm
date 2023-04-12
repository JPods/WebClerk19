
var $event_o : Object
var $eventCode_i : Integer

$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=On Load:K2:1)
		var $cDefaults : Collection
		//$cDefaults.push(New object([Item]itemNum
		$fields_t:="itemNum,description,qtyOrdered,qtyShipped,qtyBackLogged,unitPrice,discount,extendedPrice,backOrdAmount,unitCost,extendedCost"
		$obSetup:=New object:C1471("listboxName"; "LB_OrderLineOB"; "tableName"; "OrderLine"; "fieldList"; $fields_t; "priority"; "textBlock"; "columnAdder"; "ob")
		//LBX_DraftFromFieldString($obSetup)
End case 
