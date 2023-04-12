
// Modified by: Bill James (2022-08-20T05:00:00Z)
// Method: DataBrowser.LB_Show
// Description 
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Close Box:K2:21)
	: (Form event code:C388=On Load:K2:1)
	: (Form event code:C388=On Clicked:K2:4)
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Form:C1466.LB_Show.pos>0)
			var $cnt : Integer
			$cnt:=Form:C1466.LB_Fields.ents.length
			Form:C1466.LB_Fields.ents.push(Form:C1466.LB_Show.cur).orderBy("fieldName asc")
			$cnt:=Form:C1466.LB_Fields.ents.length
			Form:C1466.LB_Fields.ents:=Form:C1466.LB_Fields.ents
			
			// bypass for now
			//var $fieldName : Text
			//var $c : Collection
			//var $int : Integer
			//$fieldName:=Form.LB_Show.cur.fieldName
			////OBJECT SET SCROLL POSITION(*; "LB_Fields"; Form.LB_Fields.ents.indexOf(\
				Form.LB_Fields.ents.fieldName=$fieldName))
			//$int:=Form.LB_Fields.ents.indexOf("fieldName = "+$fieldName)
			//// OBJECT SET SCROLL POSITION(*; "LB_Fields"; Form.LB_Fields.ents.fieldName.indexOf($fieldName)[0])
			//LISTBOX SELECT ROW(*; "LB_Fields"; Form.LB_Fields.pos)
			
			Form:C1466.LB_Show.ents:=Form:C1466.LB_Show.ents.remove(Form:C1466.LB_Show.pos-1; 1)
			If (Form:C1466.LB_Show.pos>Form:C1466.LB_Show.ents.length)
				Form:C1466.LB_Show.pos:=Form:C1466.LB_Show.ents.length
			End if 
			OBJECT SET SCROLL POSITION:C906(*; "LB_Show"; Form:C1466.LB_Show.pos)
			LISTBOX SELECT ROW:C912(*; "LB_Show"; Form:C1466.LB_Show.pos)
		End if 
	: (Form event code:C388=On Selection Change:K2:29)
		
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		
		
	: (Form event code:C388=On Drag Over:K2:13)
		
	: (Form event code:C388=On Drop:K2:12)
		var lbDragFrom_t : Text
		If (lbDragFrom_t="LB_Fields")
			lbDragFrom_t:=""
			var line_o : Object
			For each (line_o; Form:C1466.LB_Fields.sel)
				//Form.LB_Show.ents.push(line_o)
				Form:C1466.LB_Show.ents:=Form:C1466.LB_Show.ents.insert(Form:C1466.LB_Show.pos; line_o)
				Form:C1466.LB_Show.pos:=Form:C1466.LB_Show.pos+1
			End for each 
			OBJECT SET SCROLL POSITION:C906(*; "LB_Show"; Form:C1466.LB_Show.pos)
			LISTBOX SELECT ROW:C912(*; "LB_Show"; Form:C1466.LB_Show.pos)
			
			Form:C1466.LB_Fields.setMinus("fieldName"; Form:C1466.LB_Fields.sel; Form:C1466.LB_Fields.ents)
			If (Form:C1466.LB_Fields.ents.length<Form:C1466.LB_Fields.pos)
				Form:C1466.LB_Fields.pos:=Form:C1466.LB_Fields.ents.length
			End if 
			OBJECT SET SCROLL POSITION:C906(*; "LB_Fields"; Form:C1466.LB_Fields.pos-1)
			LISTBOX SELECT ROW:C912(*; "LB_Fields"; Form:C1466.LB_Fields.pos)
			// HOWTO:subtract collections
		Else 
			var $i : Integer
			var $line_o : Object
			$line_o:=Form:C1466.LB_Show.cur
			$line_o:=Form:C1466.LB_Show.ents[Form:C1466.LB_Show.pos-1]
			$i:=FORM Event:C1606.row
			Form:C1466.LB_Show.ents:=Form:C1466.LB_Show.ents.remove(Form:C1466.LB_Show.pos-1; 1)
			If (($i>Form:C1466.LB_Show.ents.length) | ($i=0))
				$i:=Form:C1466.LB_Show.ents.length
			End if 
			Form:C1466.LB_Show.ents:=Form:C1466.LB_Show.ents.insert($i; $line_o)
			
			
			
			//https://discuss.4d.com/t/listbox-drag-and-drop-order-by-users/20851/5
			//https ://discuss.4d.com/t/drag-drop-in-listbox-and-reorder-lines/12601/2
			//https://discuss.4d.com/t/listbox-drag-and-drop-order-by-users/20851/5
		End if 
End case 
