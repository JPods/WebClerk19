
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aQueries; 0)
		var $c : Collection
		$c:=ds:C1482.TallyMaster.query("tableName = :1 and purpose = :2"; process_o.dataClassName; "query").toCollection("name")
		If (($c.length=0) & (process_o.dataClassName="Customer"))
			var $o : Object
			For ($i; 1; 3)
				$o:=ds:C1482.TallyMaster.new()
				$o.purpose:="query"
				$o.tableName:="Customer"
				Case of 
					: ($i=1)
						$o.name:="test-actionCedar"
						$o.script:="process_o.ents:=ds.Customer.query(\"actionBy = :1\";\"Cedar\")"
					: ($i=2)
						$o.name:="test-actionOmie"
						$o.script:="process_o.ents:=ds.Customer.query(\"actionBy = :1\";\"Omie\")"
					: ($i=3)
						$o.name:="test-actionDale"
						$o.script:="process_o.ents:=ds.Customer.query(\"actionBy = :1\";\"Dale\")"
				End case 
				$o.save()
				var $cr : Collection
				$cr:=$o.toCollection()
				
				$c.push($o.toCollection("name"))
			End for 
			If ($c.length=0)  // test to see if I got it right
				$c:=ds:C1482.TallyMaster.query("tableName = :1 and purpose = :2"; process_o.dataClassName; "query").toCollection("name")
			End if 
		End if 
		$c.orderBy("name")
		$c:=$c.extract("name")
		// build in reverse order
		$c.insert(0; "--")
		$c.insert(0; "Edit TallyMasters")
		$c.insert(0; "--")
		$c.insert(0; "query scripts")
		COLLECTION TO ARRAY:C1562($c; aQueries)
		aQueries:=1
	: (Form event code:C388=On Clicked:K2:4)
		process_o.entitySave()
		TallyMastersExecuteSearch(Self:C308)
End case 


// from class TableShow
//entry_o:=process_o.LB_Selection.selectChanged()
//entry_o:=process_o.selectChanged()


