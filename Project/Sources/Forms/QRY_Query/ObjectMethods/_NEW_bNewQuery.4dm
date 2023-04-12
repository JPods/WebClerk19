var $name_t : Text
var $oRec; $oSel : Object
$name_t:=Request:C163("Query name?")
If ((OK=1) & ($name_t#""))
	$oRec:=ds:C1482.TallyMaster.query(\
		"name = :1 and purpose = :2 and tableName = :3"; \
		$name_t; \
		"QuerySaved"; \
		Form:C1466.dataClass.getInfo().name)
	If ($oRec.length=0)
		$oRec:=ds:C1482.TallyMaster.new()
		$oRec.name:=$name_t
		$oRec.purpose:="QuerySaved"
		$oRec.tableName:=Form:C1466.dataClassName
		$oRec.obField:=qryDraft_o
		$oRec.publish:=1
		$oRec.save()
		choices_o.getQueries()
	Else 
		ALERT:C41("There is an existing query by that name.")
	End if 
End if 
