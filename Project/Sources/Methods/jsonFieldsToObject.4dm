//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/03/20, 21:46:00
// ----------------------------------------------------
// Method: jsonFieldsToObject
// Description
// REF: jsonRecordToObject
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($0)
C_TEXT:C284($1; $tableName; $2; $fieldList; $uniqueFieldName)
C_TEXT:C284($3; $vtMapTF)
$vtMapTF:=""
If (Count parameters:C259>2)
	$vtMapTF:=$3
End if 
C_LONGINT:C283($tableNum; $fieldNum)
C_OBJECT:C1216(obSummaryData)
//obSummaryData:=New object

C_OBJECT:C1216($objTable)

$voTableData:=New object:C1471
$tableName:=$1
$fieldList:=$2

$tableNum:=STR_GetTableNumber($tableName)


If ($tableNum<1)
	If (<>viDebugMode>410)
		ConsoleMessage("Bad TableName, jsonRecordToObject: "+$tableName)
	End if 
	OB SET:C1220(obSummaryData; "Error"; "NoSuchTableName")
Else 
	C_LONGINT:C283($foundField)
	ARRAY TEXT:C222($atFieldNames; 0)  // will be rezeroed in jsonMapExtract list here for clarity 
	ARRAY LONGINT:C221($alFieldNums; 0)
	If ($fieldList="all")
		Case of 
			: ($tableName="Item")
				curTableNum:=4
			: ($tableName="Order")
				curTableNum:=3
			: ($tableName="Proposal")
				curTableNum:=42
			: ($tableName="Invoice")
				curTableNum:=26
			: ($tableName="Customer")
				curTableNum:=2
		End case 
		StructureFields(curTableNum)
		COPY ARRAY:C226(theFields; $atFieldNames)
	Else 
		TextToArray($fieldList; ->$atFieldNames; ",")
	End if 
	
	$cntRay:=Size of array:C274($atFieldNames)
	If ($cntRay=0)
		OB SET:C1220($voTableData; "Error"; "NoFieldList")
		$cntRay:=0
	Else 
		If (Locked:C147(Table:C252($tableNum)->))
			OB SET:C1220($voTableData; "lockedStatus"; True:C214)
		Else 
			OB SET:C1220($voTableData; "lockedStatus"; False:C215)
		End if 
		C_POINTER:C301($ptField)
		C_OBJECT:C1216($objField)
		C_TEXT:C284($vtFieldName)
		C_LONGINT:C283($viFieldNum)
		For ($incRay; 1; $cntRay)
			$ptField:=STR_GetFieldPointer($tableName; $atFieldNames{$incRay})
			If (Not:C34(Is nil pointer:C315($ptField)))
				$typeFld:=Type:C295($ptField->)
				If (Not:C34(($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12)))  // no blobs or pictures
					//OB SET($voTableData;Lowercase($atFieldNames{$incRay});$ptField->)
					If ($atFieldNames{$incRay}="DT@")
						C_TEXT:C284($vtDT)
						$vtDT:=jDateTimeRBoth($ptField->)
						If ($vtMapTF="TF")
							OB SET:C1220($voTableData; $tableName+"_"+$atFieldNames{$incRay}; $vtDT)
						Else 
							OB SET:C1220($voTableData; $atFieldNames{$incRay}; $vtDT)
						End if 
					Else 
						If ($vtMapTF#"")
							OB SET:C1220($voTableData; $tableName+"_"+$atFieldNames{$incRay}; $ptField->)
						Else 
							OB SET:C1220($voTableData; $atFieldNames{$incRay}; $ptField->)
						End if 
					End if 
				End if 
			End if 
		End for 
		C_OBJECT:C1216(obTallyMasters)
		obTallyMasters:=New object:C1471
		Execute_TallyMaster($tableName; "jsonFieldsToObject")
		If (obTallyMasters#Null:C1517)
			OB SET:C1220($voTableData; "TallyMaster"; obTallyMasters)
		End if 
		obTallyMasters:=New object:C1471
	End if 
End if 
$0:=$voTableData



