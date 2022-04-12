var $obRec : Object
$obRec:=ds:C1482.FieldCharacteristic.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "formDefault"; "default").first()
If ($obRec=Null:C1517)
	$obRec:=ds:C1482.FieldCharacteristic.new()
	$obRec.tableName:=tableName
	$obRec.purpose:="formDefault"
	$obRec.role:="default"
	$obRec.save()
End if 
