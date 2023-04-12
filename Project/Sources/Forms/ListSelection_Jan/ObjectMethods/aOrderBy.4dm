Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aOrderBy; 0)
		var $c : Collection
		
		
		
		$c:=ds:C1482.TallyMaster.query("tableName = :1 and purpose = :2"; process_o.dataClassName; "orderBy").toCollection("name")
		If (($c.length=0) & (process_o.dataClassName="Customer"))
			var $o : Object
			For ($i; 1; 3)
				$o:=ds:C1482.TallyMaster.new()
				$o.purpose:="orderBy"
				$o.tableName:="Customer"
				Case of 
					: ($i=1)
						$o.name:="test-company"
						$o.script:="process_o.ents.orderBy(\"company\")"
					: ($i=2)
						$o.name:="test-nameFirst"
						$o.script:="process_o.ents.orderBy(\"nameFirst\")"
					: ($i=3)
						$o.name:="test-actionDate"
						$o.script:="process_o.ents.orderBy(\"actionDate\")"
				End case 
				$o.save()
			End for 
			If ($c.length=0)  // test to see if I got it right
				$c:=ds:C1482.TallyMaster.query("tableName = :1 and purpose = :2"; process_o.dataClassName; "orderBy").toCollection("name")
			End if 
		End if 
		$c.orderBy("name")
		$c:=$c.extract("name")
		// build in reverse order
		$c.insert(0; "--")
		$c.insert(0; "Edit TallyMasters")
		$c.insert(0; "--")
		$c.insert(0; "orderBy scripts")
		COLLECTION TO ARRAY:C1562($c; aOrderBy)
		aOrderBy:=1
	: (Form event code:C388=On Clicked:K2:4)
		process_o.entitySave()
		TallyMasterExecuteOrderBy(Self:C308)
End case 