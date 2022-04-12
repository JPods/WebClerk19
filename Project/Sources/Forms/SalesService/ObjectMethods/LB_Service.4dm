var obRec; obSel : Object
var $viClickCount : Integer
If (FORM Event:C1606.objectName="LB_Service")
	Case of 
		: (Form event code:C388=On Header Click:K2:40)
			$viClickCount:=Clickcount:C1332
			Case of 
				: (Clickcount:C1332=1)
					//single-click action
				: (Clickcount:C1332=2)
					//double-click action
			End case 
		: (Form event code:C388=On Footer Click:K2:55)
			$viClickCount:=Clickcount:C1332
			Case of 
				: (Clickcount:C1332=1)
					//single-click action
				: (Clickcount:C1332=2)
					//double-click action
			End case 
			
		: (Form event code:C388=On Selection Change:K2:29)
			
			ConsoleMessage("In ListBox On Selection Change")
			
		: (Form event code:C388=On Double Clicked:K2:5)  //  (Form event code=On Double Clicked)
			If (cServiceAction.cur#Null:C1517)
				
				process_o.id:=cServiceAction.cur.id
				process_o.tableName:=cServiceAction.cur.tableName
				
				var $new_o : Object
				$new_o:=New object:C1471("ents"; New object:C1471; \
					"cur"; New object:C1471; \
					"sel"; New object:C1471; \
					"pos"; -1; \
					"entsOther"; New object:C1471("tableName"; New object:C1471); \
					"tableName"; process_o.tableName; \
					"form"; "Input"; \
					"tableForm"; process_o.tableName+"_Input"; \
					"id"; cServiceAction.cur.id; \
					"parent"; Current process:C322)
				$viProcess:=New process:C317("Process_ByID"; 0; process_o.tableName+" - "+String:C10(Count tasks:C335); $new_o)
				
			End if 
			
		: (Form event code:C388=On Clicked:K2:4)  // (Form event code=On Clicked)
			$viClickCount:=Clickcount:C1332
			var $ptTable : Pointer
			$ptTable:=STR_GetTablePointer(cServiceAction.cur.tableName)
			OBJECT SET SUBFORM:C1138(*; "SF_Input"; $ptTable->; "InputDS")
			var $o : Object
			$o:=New object:C1471("tableName"; cServiceAction.cur.tableName; "id"; cServiceAction.cur.id)
			EntityLoad($o)
	End case 
End if 