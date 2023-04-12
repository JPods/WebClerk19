
var $event_o : Object
var $eventCode_i : Integer
$event_o:=FORM Event:C1606
$eventCode_i:=Form event code:C388

Case of 
	: ($eventCode_i=On Close Box:K2:21)
	: ($eventCode_i=On Load:K2:1)
	: ($eventCode_i=On Clicked:K2:4)
	: ($eventCode_i=On Double Clicked:K2:5)
		// add to fields to display
		Form:C1466.LB_Show.ents:=Form:C1466.LB_Show.ents.insert(Form:C1466.LB_Show.pos; Form:C1466.LB_Fields.cur)
		// add line below currently selected
		Form:C1466.LB_Show.pos:=Form:C1466.LB_Show.pos+1
		OBJECT SET SCROLL POSITION:C906(*; "LB_Show"; Form:C1466.LB_Show.pos)
		LISTBOX SELECT ROW:C912(*; "LB_Show"; Form:C1466.LB_Show.pos)
		// remove from choices
		// Form.LB_Fields.setMinus("fieldName"; Form.LB_Fields.cur; Form.LB_Fields.ents)
		// remove currently selected
		Form:C1466.LB_Fields.pos:=Form:C1466.LB_Fields.pos-1
		Form:C1466.LB_Fields.ents.remove(Form:C1466.LB_Fields.pos; 1)
		OBJECT SET SCROLL POSITION:C906(*; "LB_Fields"; Form:C1466.LB_Fields.pos)
		LISTBOX SELECT ROW:C912(*; "LB_Fields"; Form:C1466.LB_Fields.pos)
		
		
	: ($eventCode_i=On Selection Change:K2:29)
		
		
		
		//Form.sfSelection:=cs.cEditSubForm
		//Form.sfSelection:=cs.cEditSubForm.new("SF_List"; "Customer")
		//Form.sfSelection.setLBFromCollection(Form.LB_Fields.sel.extract("fieldName"))
		//LBX_SelectionIfEmpty(Form.sfSelection.lbName; Form.form_o.dataClassName)
		//Form.sfSelection.setFieldPopUp()
	: ($eventCode_i=On Begin Drag Over:K2:44)
		// set a variable to note the source of the items being dropped
		lbDragFrom_t:="LB_Fields"
		
	: ($eventCode_i=On Drag Over:K2:13)
		
	: ($eventCode_i=On Drop:K2:12)
		
End case 
