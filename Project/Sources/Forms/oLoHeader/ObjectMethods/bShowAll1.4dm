//OutputFormAllRecords

// FHolo_All("Customer")


C_TEXT:C284($1; $tableName; tableName)
If (Count parameters:C259=0)
	If (tableName="")
		tableName:="Customer"
	End if 
	$tableName:=tableName
Else 
	If (Count parameters:C259>0)
		$tableName:=$1
		// define the form object
	End if 
End if 
entSel:=ds:C1482[$tableName].all()