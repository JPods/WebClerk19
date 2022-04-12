var $event_o : Object
var $eventCode_i : Integer
$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=On Load:K2:1)
		READ ONLY:C145([Item:4])
		var process_o : Object
		If (process_o=Null:C1517)
			process_o:=New object:C1471("ents"; New object:C1471; \
				"cur"; New object:C1471; \
				"sel"; New object:C1471; \
				"pos"; -1; \
				"tableName"; "Item"; \
				"tableForm"; ""; \
				"form"; "QuickQuote"; \
				"entsOther"; New object:C1471("tableName"; New object:C1471); \
				"process"; Current process:C322)
		End if 
	: ($event_o.code=On Clicked:K2:4)
		If (Form:C1466.ItemCurrent#Null:C1517)
			QUERY:C277([Item:4]; [Item:4]id:123=Form:C1466.ItemCurrent.id)
			Item_GetSpec
		End if 
End case 

