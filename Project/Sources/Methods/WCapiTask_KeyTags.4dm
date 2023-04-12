//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/20, 17:56:04
// ----------------------------------------------------
// Method: WCapiTask_KeyTags
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($vtKeyWord)
C_POINTER:C301($ptTable; $ptObjField; $ptTagField)
C_LONGINT:C283($viTableNum)
C_TEXT:C284($tableName; $vtTableNameLC)
$vtKeyWord:=WCapi_GetParameter("keyTags"; "")  // in value pairs
$tableName:=WCapi_GetParameter("tableName"; "")  // in value pairs

If (($vtKeyWord="") | ($tableName=""))
	vResponse:="Error: Must have valid data in KeyTags: "+$vtKeyWord+" and tableName: "+$tableName
Else 
	$ptTable:=STR_GetTablePointer($tableName)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: Invalid tableName: "+$tableName
		ConsoleLog("Error: WCapiTask_KeyTags: "+$tableName)
	Else 
		$tableName:=Table name:C256($ptTable)
		ARRAY TEXT:C222($atMyKeywords; 0)
		$vtKeyWord:=KeyWordCleanup($vtKeyWord)
		KeyWordByTag($tableName; $vtKeyWord)
		$vtRole:="Sales"
		$vtPurpose:="list"
		$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
		$obSel:=API_SelectionToObject($tableName)
		vResponse:=API_EntityToText($obSel; $vtFieldList)
		
		voState.result:=$tableName+" records in selection: "+String:C10($obSel.length)
	End if 
End if 
//$0:=vResponse
