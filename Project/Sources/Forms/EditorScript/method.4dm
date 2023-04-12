
var $event_o : Object
var $eventCode_i : Integer
$event_o:=FORM Event:C1606
$eventCode_i:=Form event code:C388

Case of 
	: (Form event code:C388=On Load:K2:1)
		//J_Programing
		vTextSummary:=""
		vlead:=""
		process_o:=cs:C1710.TableShow.new(Form:C1466.dataClassName)
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
