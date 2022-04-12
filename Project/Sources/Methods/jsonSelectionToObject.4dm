//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/13/19, 13:38:07
// ----------------------------------------------------
// Method: jsonSelectionToObject
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptObject)
C_TEXT:C284($2; $tableName; $3; $fieldlist; $jtTemplate)
C_LONGINT:C283($tableNum; $fieldNum)
C_POINTER:C301($ptTable)
C_POINTER:C301($ptField)

ARRAY OBJECT:C1221($aObData; 0)
C_TEXT:C284($errorMessage)

C_OBJECT:C1216($voTemplate)
$voTemplate:=New object:C1471

$ptObject:=$1
$tableName:=$2
If (Count parameters:C259>2)
	$fieldlist:=$3
End if 
If (Count parameters:C259=0)
	$errorMessage:="ErrNoTableName"
Else 
	$tableNum:=STR_GetTableNumber($tableName)
	If ($tableNum<1)
		$errorMessage:="IncorrectTableName"
	End if 
End if 
If ($errorMessage#"")
	INSERT IN ARRAY:C227($aObData; 1; 1)
	OB SET:C1220($aObData{1}; "Error"; $errorMessage)
	OB SET ARRAY:C1227($ptObject->; $tableName; $aObData)
Else 
	If ($fieldlist="all fields")
		$cntRay:=Get last field number:C255($tableNum)
		For ($incRay; 1; $cntRay)
			$ptField:=Field:C253($tableNum; $incRay)
			$typeFld:=Type:C295($ptField->)
			If (Not:C34(($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12)))  // no blobs or pictures
				OB SET:C1220($voTemplate; Field name:C257($ptField); $ptField)  // build name:pointer to field into template
			End if 
		End for 
	Else 
		$ptTable:=Table:C252($tableNum)
		$tableName:=Table name:C256($tableNum)  // fix case defects
		ARRAY TEXT:C222($atFieldNames; 0)  // will be rezeroed in jsonMapExtract list here for clarity 
		ARRAY TEXT:C222($atMapNames; 0)
		ARRAY LONGINT:C221($alFieldNums; 0)
		jsonMapExtract($tableName; ->$atFieldNames; ->$atMapNames; ->$alFieldNums)
		
		$cntRay:=Size of array:C274($atMapNames)
		If ($cntRay=0)
			$errorMessage:="NoFieldMap"
		Else 
			For ($incRay; 1; $cntRay)
				$ptField:=Field:C253($tableNum; $alFieldNums{$incRay})
				$typeFld:=Type:C295($ptField->)
				If (Not:C34(($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12)))  // no blobs or pictures
					OB SET:C1220($voTemplate; $atMapNames{$incRay}; $ptField)  // build name:pointer to field into template
				End if 
			End for 
		End if 
	End if 
	
	
	$vtDataArray:=Selection to JSON:C1234($ptTable->; $voTemplate)
	JSON PARSE ARRAY:C1219($vtDataArray; $aObData)
	OB SET ARRAY:C1227($ptObject->; $tableName; $aObData)
End if 
