var $event_o : Object
var $eventCode_i : Integer
$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=On Load:K2:1)
		var process_o : Object
		If (process_o.related.Customer=Null:C1517)
			process_o.related.Customer:=ds:C1482.Customer.query("customerID = :1"; entry_o.customerID).first()
		End if 
		_LB_FieldList_:=cs:C1710.listboxK.new("_LB_FieldList_")
		_LB_FieldList_.ents:=_LB_FieldList_.setRecord(process_o.cur).orderBy("name")
		//var $c : Collection
		//var $o : Object
		//var $name : Text
		$c:=New collection:C1472
		//For each ($name;ds.Item.getInfo)
		//$c.push(new object($name
		//End for each
		//_LB_Item_.setSource(ds.Item.query("itemNum = :1"; "FRP@"))
		
	: ($event_o.code=On Clicked:K2:4)
		
End case 

