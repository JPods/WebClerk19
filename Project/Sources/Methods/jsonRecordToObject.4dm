//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/09/19, 00:36:58
// ----------------------------------------------------
// Method: jsonRecordToObject
// Description
//  REF: jsonFieldsToObject
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptObject)
C_TEXT:C284($2; $tableName)
C_TEXT:C284($3; $vtCommand)
C_LONGINT:C283($tableNum)
C_LONGINT:C283($incRay; $cntRay)
C_OBJECT:C1216($vobData)
$ptObject:=$1
$tableName:=$2

If (Count parameters:C259>2)
	$vtCommand:=$3
End if 

$tableNum:=STR_GetTableNumber($tableName)

If ($tableNum<1)
	If (<>viDebugMode>410)
		ConsoleMessage("Bad TableName, jsonRecordToObject: "+$tableName)
	End if 
	OB SET:C1220($vobData; "Error"; "NoSuchTableName")
Else 
	$tableName:=Table name:C256($tableNum)  // fix case defects
	ARRAY TEXT:C222($atFieldNames; 0)  // will be rezeroed in jsonMapExtract list here for clarity 
	ARRAY TEXT:C222($atMapNames; 0)
	ARRAY LONGINT:C221($alFieldNums; 0)
	
	If ($vtCommand="all fields")
		$cntRay:=Get last field number:C255($tableNum)
		C_POINTER:C301($ptField)
		$vobData:=New object:C1471
		For ($incRay; 1; $cntRay)
			$ptField:=Field:C253($tableNum; $incRay)
			$typeFld:=Type:C295($ptField->)
			If (Not:C34(($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12)))  // no blobs or pictures
				OB SET:C1220($vobData; Field name:C257($tableNum; $incRay); Field:C253($tableNum; $incRay)->)  // build name:pointer to field into template
			End if 
		End for 
	Else 
		jsonMapExtract($tableName; ->$atFieldNames; ->$atMapNames; ->$alFieldNums; $vtCommand)
		$cntRay:=Size of array:C274($atMapNames)
		If ($cntRay=0)
			OB SET:C1220($vobData; "Error"; "NoMap")
			$cntRay:=0
		Else 
			C_POINTER:C301($ptField)
			For ($incRay; 1; $cntRay)
				$ptField:=Field:C253($tableNum; $alFieldNums{$incRay})
				$typeFld:=Type:C295($ptField->)
				If (Not:C34(($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12)))  // no blobs or pictures
					OB SET:C1220($vobData; $atMapNames{$incRay}; $ptField->)  // build name:pointer to field into template
				End if 
			End for 
		End if 
	End if 
End if 
TRACE:C157  // TESTTHIS
// ### bj ### 20201209_0041
C_OBJECT:C1216(obTallyMasters)
obTallyMasters:=New object:C1471
Execute_TallyMaster($tableName; "jsonRecordToObject")
If (obTallyMasters#Null:C1517)
	$vobData.tallyMasters:=obTallyMasters
End if 
obTallyMasters:=New object:C1471

OB SET:C1220($ptObject->; $tableName; $vobData)


