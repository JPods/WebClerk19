
var $event_o : Object
var $eventCode_i : Integer
$event_o:=FORM Event:C1606
$eventCode_i:=Form event code:C388

Case of 
	: ($eventCode_i=On Load:K2:1)
		Process_InitLocal
		
		
End case 
