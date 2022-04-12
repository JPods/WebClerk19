var $event_o : Object
$event_o:=FORM Event:C1606
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Selection Change:K2:29)
		//If (Form.cur=Null)
		//REDUCE SELECTION(ptCurTable->; 0)
		//Else 
		
		var $subForm_o : Object
		var $methodName_t : Text
		$subForm_o:=New object:C1471("tableName"; process_o.tableName; \
			"id"; Form:C1466.cur.id)
		$methodName_t:="SF_InputLoad"
		EXECUTE METHOD IN SUBFORM:C1085("SF_Input"; $methodName_t; *; $subForm_o)
		//  EXECUTE METHOD IN SUBFORM("SF_Input"; "SF_InputLoad"; *; tableName; "Order")
		process_o.cur:=Form:C1466.cur
		process_o.old:=process_o.cur.clone()
		process_o.entsOther[process_o.tableName]:=Form:C1466.cur
		Storage_LastRecord(process_o.tableName; process_o.cur.id)
		
		
	: ($event_o.code=On Double Clicked:K2:5)
		var $obPassable; entryEntity : Object
		entryEntity:=Form:C1466.cur.toObject()
		$obPassable:=New object:C1471("tableName"; process_o.tableName; \
			"form"; "Input"; "tableForm"; process_o.tableName+"_Input"; \
			"id"; Form:C1466.cur.id; \
			"parent"; Current process:C322)
		$viProcess:=New process:C317("Process_ByID"; 0; process_o.tableName+" - "+String:C10(Count tasks:C335); $obPassable)
End case 