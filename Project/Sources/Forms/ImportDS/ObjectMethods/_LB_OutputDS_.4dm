var $event_o : Object
var $eventCode_i : Integer
$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=On Load:K2:1)
		
	: ($eventCode_i=On Selection Change:K2:29)
		If (Form:C1466.cur=Null:C1517)
			REDUCE SELECTION:C351(ptCurTable->; 0)
		Else 
			
			var $subForm_o : Object
			var $methodName_t : Text
			$subForm_o:=New object:C1471("tableName"; process_o.tableName; "id"; Form:C1466.cur.id)
			$methodName_t:="SF_InputLoad"
			EXECUTE METHOD IN SUBFORM:C1085("SF_Input"; $methodName_t; *; $subForm_o)
			//  EXECUTE METHOD IN SUBFORM("SF_Input"; "SF_InputLoad"; *; tableName; "Order")
			
		End if 
		
	: ($event_o.code=On Double Clicked:K2:5)
		var $new_o : Object
		$new_o:=New object:C1471("ents"; Form:C1466.cur; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; ""; \
			"tableForm"; process_o.tableName+"_Input"; \
			"Form"; "Input"; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
		//$new_o:=New object("ents"; New object; "tableName"; process_o.tableName; \
						"form"; "Input"; \
						"tableForm"; process_o.tableName+"_Input"; \
						"id"; Form.cur.id; \
						"parent"; Current process)
		$viProcess:=New process:C317("Process_ByID"; 0; process_o.tableName+" - "+String:C10(Count tasks:C335); $new_o)
End case 