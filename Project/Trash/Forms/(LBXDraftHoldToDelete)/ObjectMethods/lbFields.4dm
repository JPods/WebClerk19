
var $event_o : Object
var $eventCode_i : Integer
$event_o:=FORM Event:C1606
$eventCode_i:=Form event code:C388

Case of 
	: ($eventCode_i=On Close Box:K2:21)
	: ($eventCode_i=On Load:K2:1)
	: ($eventCode_i=On Clicked:K2:4)
	: ($eventCode_i=On Double Clicked:K2:5)
		
		
	: ($eventCode_i=On Begin Drag Over:K2:44)
		lbDragFrom_t:="lbFields"
		
	: ($eventCode_i=On Drag Over:K2:13)
		
	: ($eventCode_i=On Drop:K2:12)
		If (lbDragFrom_t="LBDraftTable")
			
			
		End if 
End case 
