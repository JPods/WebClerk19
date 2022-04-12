
C_OBJECT:C1216(obRec)
obRec:=ds:C1482.FieldCharacteristic.query(" tableName = :1 AND purpose = :2 "; tableName; "formDefault").first()
$vtScript:="Query([FieldCharacteristic];[FieldCharacteristic]id=\""+obRec.id+"\")"
// $vtScript:="obRec:=ds.FieldCharacteristic.query(\" tableName = :1 AND purpose = :2 \"; "+tableName+"; \"formDefault\").first()"

ProcessTableOpen(Table:C252(->[FieldCharacteristic:94]); $vtScript; "Template")

If (False:C215)
	C_LONGINT:C283($viProcess)
	C_OBJECT:C1216($obNewProcess)
	$obNewProcess:=New object:C1471("tableName"; "FieldCharacteristic"; "script"; $vtScript; "form"; "Input"; "processParent"; Current process name:C1392; "windowParent"; ""; "task"; "ShowRecord")
	
	C_TEXT:C284($vtScript)
	
	
	//$obNewProcess:=New process("ProcessFromObject"; 0; "FieldCharacteristic-"+String(Count tasks); $obNewProcess)
	
	//ProcessShowRecord
End if 