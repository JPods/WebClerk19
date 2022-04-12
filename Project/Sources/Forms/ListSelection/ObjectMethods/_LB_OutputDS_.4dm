var $event_o : Object
$event_o:=FORM Event:C1606
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		SF_List_Execute("_LB_OutputDS_")
		
	: (Form event code:C388=On Clicked:K2:4)  //                (Form event code=On Clicked)
		
		// attempts to get forms talking resolved by changing process_o.cur and letting On Selection Changed operate
		//SF_Tell(OBJECT Get pointer(Object current); OBJECT Get value(OBJECT Get name(Object current)))
		//CALL SUBFORM CONTAINER(-122)
		Storage_LastRecord(process_o.tableName; process_o.cur.id)
		process_o.cur:=_LB_OutputDS_.cur
		entryEntity:=_LB_OutputDS_.cur.toObject()
		process_o.old:=process_o.cur.clone()
		
	: (Form event code:C388=On Selection Change:K2:29)
		var $subForm_o : Object
		var $methodName_t : Text
		
		
		
		
	: ($event_o.code=On Double Clicked:K2:5)
		var $obPassable; entryEntity : Object
		process_o.cur:=_LB_OutputDS_.cur
		entryEntity:=_LB_OutputDS_.cur.toObject()
		Process_ByID
End case 