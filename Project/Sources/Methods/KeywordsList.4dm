//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/30/20, 07:16:47
// ----------------------------------------------------
// Method: KeywordsList
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obRec; $obSel)
C_COLLECTION:C1488($cKeys)
$cKeys:=New collection:C1472
$obSel:=ds:C1482.DefaultSetup.query("nameID = :1"; "<>aKeyQuery")
If ($obSel.first()=Null:C1517)
	$obRec.new()
	$obRec.nameID:="<>aKeyQuery"
	$obRec.variableName:="<>aKeyQuery"
	$obRec.script:="test,this,that"
	$result_o:=$obRec.save()
Else 
	$obRec:=$obSel.first()
	$cKeys:=Split string:C1554($obRec.script; ",")
	$cKeys:=$cKeys.distinct()
	ARRAY TEXT:C222(<>aKeyQuery; 0)
	COLLECTION TO ARRAY:C1562($cKeys; <>aKeyQuery)
	SORT ARRAY:C229(<>aKeyQuery)
	INSERT IN ARRAY:C227(<>aKeyQuery; 1; 1)
	<>aKeyQuery{1}:="Keywords"
End if 

If (False:C215)
	C_TEXT:C284($vtTest; $vtTest2; $vtTest3)
	ProcessTableOpen(Table:C252(->[DefaultSetup:86]); "QUERY([DefaultSetup];[DefaultSetup]nameID=\"<>aKeyQuery\")")
End if 