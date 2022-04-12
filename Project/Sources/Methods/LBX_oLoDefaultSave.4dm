//%attributes = {"publishedWeb":true}
//LBX_oLoDefaultSave

C_OBJECT:C1216($obTableOutput; $1)
$obTableOutput:=$1
C_OBJECT:C1216($obRec; $obSel)

var $obRec : Object
$obRec:=ds:C1482.FieldCharacteristic.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "draft"; "draft").first()
If ($obRec=Null:C1517)
	ConsoleMessage($obTableOutput.tableName+" new draft of output layout")
	$obRec:=ds:C1482.FieldCharacteristic.new()
	$obRec.tableName:=$obTableOutput.tableName
	$obRec.purpose:="draft"
	$obRec.role:="draft"
	
	
	$obRec.data:=New object:C1471("draft"; $obTableOutput.textNames)
Else 
	ConsoleMessage($obTableOutput.tableName+" new draft of output layout")
End if 
$obRec.data.draftOb:=$obTableOutput
$obRec.data.FormDefault:=$obTableOutput.textNames
$obRec.data.tableName:=$obTableOutput.tableName
$result_o:=$obRec.save()