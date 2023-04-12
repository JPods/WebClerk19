
var $event_o : Object
var $eventCode_i : Integer
$event_o:=FORM Event:C1606
$eventCode_i:=Form event code:C388

Case of 
	: ($eventCode_i=On Close Box:K2:21)
	: ($eventCode_i=On Load:K2:1)
	: ($eventCode_i=On Clicked:K2:4)
	: ($eventCode_i=On Double Clicked:K2:5)
		
	: ($eventCode_i=On Selection Change:K2:29)
		Form:C1466.sfSelection:=cs:C1710.cEditSubForm
		Form:C1466.sfSelection:=cs:C1710.cEditSubForm.new("SF_Selection"; "Customer")
		Form:C1466.sfSelection.setLBFromCollection(Form:C1466.LB_Fields.sel.extract("fieldName"))
		LBX_SelectionIfEmpty(Form:C1466.sfSelection.lbName; Form:C1466.form_o.dataClassName)
		Form:C1466.sfSelection.setFieldPopUp()
	: ($eventCode_i=On Begin Drag Over:K2:44)
		lbDragFrom_t:="lbFields"
		
	: ($eventCode_i=On Drag Over:K2:13)
		
	: ($eventCode_i=On Drop:K2:12)
		If (lbDragFrom_t="LB_Draft")
			
			
		End if 
End case 
