
var $event_o : Object
var $eventCode_i : Integer

$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=-255)
		Form:C1466.OrderlineDisplayed:=ds:C1482.OrderLine.query("orderNum = :1 "; [Order:3]orderNum:2)
		
	: ($eventCode_i=On Load:K2:1)
		
		If (Record number:C243([Order:3])>0)
			Form:C1466.OrderlineDisplayed:=ds:C1482.OrderLine.query("orderNum = :1 "; [Order:3]orderNum:2)
		End if 
	: ($eventCode_i=On Clicked:K2:4)
		
		//: ($eventCode_i=(-1*(On Clicked))
		
		//Form.OrderlineDisplayed:=ds.OrderLine.query("orderNum = :1 "; [Order]orderNum)
		
	: (Form event code:C388=-255)
		
		var OrderLineDisplayed_o : Object
		OrderLineDisplayed_o:=ds:C1482.OrderLine.query("orderNum = :1 "; [Order:3]orderNum:2)
		
		
End case 