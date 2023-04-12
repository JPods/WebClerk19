$evt:=Form event code:C388
Case of 
	: ($evt=On Clicked:K2:4)
		process_o.ents:=Form:C1466.ents
		
		// QQQ save queries
		If (process_o=Null:C1517)
			process_o:=New object:C1471
		End if 
		If (process_o.query=Null:C1517)
			process_o.query:=New object:C1471
		End if 
		process_o.query.current:=New object:C1471(\
			"ents"; $displayedSelection; \
			"length"; Form:C1466.ents.length; \
			"queryString"; $queryString; \
			"queryParams"; $queryParams; \
			"queryPlan"; $queryPlan; \
			"queryPath"; $queryPath)
		
		ACCEPT:C269
End case 