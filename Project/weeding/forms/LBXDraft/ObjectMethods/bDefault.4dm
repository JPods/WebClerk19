var $listboxSetup_o; $columnSetup_o : Object
var $obRec : Object
$obRec:=ds:C1482.FC.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "formDefault"; "default").first()

If ($obRec=Null:C1517)
	ALERT:C41("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: formDefault, role default")
	ConsoleLog("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: formDefault, role default")
	
Else 
	$listboxSetup_o:=$obRec.data.default["listboxSetup"]
	If ($listboxSetup_o=Null:C1517)
		ALERT:C41("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: formDefault, role default")
		ConsoleLog("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: formDefault, role default")
	Else 
		$listboxSetup_o.listboxName:="LB_Draft"
		LBX_BoxFromStored($listboxSetup_o)
		Form:C1466.obHarvest:=$listboxSetup_o
		Form:C1466.ents:=ds:C1482[$listboxSetup_o.tableName].all()
	End if 
End if 