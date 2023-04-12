//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/02/20, 12:03:38
// ----------------------------------------------------
// Method: ObjectNotationTesting
// Description
// 
//
// Parameters
// ----------------------------------------------------





// : (voState.url="/ajax_ImagePath@")  // junk but keep to look at how to reference objects
C_TEXT:C284($vtextWorking; $tableName; $fieldName; $uniqueFieldValue; $fieldUniqueName; $vtID)
C_LONGINT:C283($p; $tableNum; $fieldNum)
C_POINTER:C301($ptTable; $ptField; $ptFieldUnique)
C_OBJECT:C1216($voPayload)
C_BLOB:C604(vblWCResponse)
TRACE:C157
$tableName:="Employee"
$ptTable:=STR_GetTablePointer($tableName)
$fieldUniqueName:=STR_GetUniqueFieldName($tableName)

If (False:C215)
	$voPayload:=New object:C1471
	$voPayload:=JSON Parse:C1218(vWCPayload)
	//$tableName:=$voPayload."tableName"
	$tableName:=Lowercase:C14($tableName)
	//$fieldName:=Lowercase($voPayload."fieldName")
End if 

// WORKING ZZZQQQZZZ
//  If (STR_IsTable ($tableName))
TRACE:C157
$tableName:="Employee"
C_OBJECT:C1216($obInfo)
C_OBJECT:C1216($dataStore; $obSel; $obAllTables; $dateStore; $dataClass)
$dataClass:=ds:C1482.Default.all().first().getDataClass()
// failed
$dateStore:=$dataClass.getDataClass().getDataStore()
// worked
$dateStore:=$dataClass.getDataStore()
$dateStore:=ds:C1482.Default.all().first().getDataClass().getDataStore()

If ($dateStore[$tableName]=Null:C1517)
	//
	//
	//
Else 
	$viTableNum:=$dateStore[$tableName].getInfo().tableNumber
End if 

$obSel:=ds:C1482.Default.all().first()
$obAllTables:=$obSel.getDataClass()
$obFields:=$obSel.getDataClass()
$obSel:=ds:C1482[$tableName].all().first()
$obFields:=$obSel.getDataClass()
If ($obSel=Null:C1517)
	
Else 
	
	
	
	
	$dateStore:=$obSel.getDataClass().getDataStore()
	$obFields:=$obSel.getDataClass()
	$viTableNum:=ds:C1482.Employee.getInfo().tableNumber
	$viTableNum:=ds:C1482[$tableName].getInfo().tableNumber
	$viTableNum:=ds:C1482.$obSel.getInfo().tableNumber
	$obInfo:=ds:C1482.$obSel.getInfo()
End if 
$ptFieldUnique:=STR_GetUniqueFieldPointer($tableName)

