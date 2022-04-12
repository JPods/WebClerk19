var $event_o : Object
var $eventCode_i : Integer

$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=On Data Change:K2:15)
		orderNum_i:=[Order:3]orderNum:2
		
	: ($eventCode_i=On Clicked:K2:4)
		orderNum_i:=[Order:3]orderNum:2
		
End case 
