//%attributes = {"publishedWeb":true}
//LBX_oLoDefaultSave

C_OBJECT:C1216($obTableOutput; $1)
$obTableOutput:=$1
C_OBJECT:C1216($fc_o; $obSel)

var $fc_o : Object
$fc_o:=ds:C1482.FC.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "draft"; "draft").first()
If ($fc_o=Null:C1517)
	ConsoleLog($obTableOutput.tableName+" new draft of output layout")
	$fc_o.id:=STR_FCNew(Form:C1466.dataClassName; "draft")
	
Else 
	ConsoleLog($obTableOutput.tableName+" new draft of output layout")
End if 
$fc_o.data.draftOb:=$obTableOutput
$fc_o.data.FormDefault:=$obTableOutput.textNames
$fc_o.data.tableName:=$obTableOutput.tableName
$result_o:=$fc_o.save()