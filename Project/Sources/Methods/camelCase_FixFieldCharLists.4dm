//%attributes = {}


C_OBJECT:C1216($obRec; $obSel)
C_COLLECTION:C1488($cBefore)
C_TEXT:C284($vtBefore; $vtFailed; $vtPassed; $vtCamelCase; $vtReport)
C_COLLECTION:C1488($cBefore; $cTested; $cFailed)
$cBefore:=New collection:C1472
$cFailed:=New collection:C1472
$cTested:=New collection:C1472

$obSel:=ds:C1482.FieldCharacteristic.all()
$cBefore:=New collection:C1472
$cComplete:=New collection:C1472
For each ($obRec; $obSel)
	$obRec.tableName:=STR_FixCaseTableName($obRec.tableName)
	$obFieldDef:=STR_GetTableDefinition($obRec.tableName)
	If ($obFieldDef=Null:C1517)
		$obRec.comment:="bad tableName"
		ConsoleMessage("FieldCharacteristic bad tableName: "+String:C10($obRec.idNum)+": "+$obRec.tableName)
	Else 
		C_TEXT:C284($vtUse)
		C_OBJECT:C1216($obReturn)
		$obReturn:=New object:C1471
		$vtUse:="list"
		$obReturn:=camelCase_Object($obRec.tableName; $obRec.$obReturn; $vtUse)
		$obRec.$obReturn[$vtUse]:=$obReturn[$vtUse]
		$obRec.$obReturn[$vtUse+"Fail"]:=$obReturn[$vtUse+"Fail"]
		$obReturn:=New object:C1471
		$vtUse:="data"
		$obReturn:=camelCase_Object($obRec.tableName; $obRec.$obReturn; $vtUse)
		$obRec.$obReturn[$vtUse]:=$obReturn[$vtUse]
		$obRec.$obReturn[$vtUse+"Fail"]:=$obReturn[$vtUse+"Fail"]
		$obRec.form:=""
		$result_o:=$obRec.save()
	End if 
End for each 