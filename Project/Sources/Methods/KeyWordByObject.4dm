//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/06/20, 00:42:47
// ----------------------------------------------------
// Method: KeywordByObject
// Description
// 
//  Keep for reference  Not sure how well this works
// Parameters
// ----------------------------------------------------
C_POINTER:C301($ptTable; $ptField)
C_TEXT:C284($1; $2; $tableName; $vtKeyword)
$tableName:=$1
$vtKeyword:=$2
$ptTable:=STR_GetTablePointer($tableName)
If (Is nil pointer:C315($ptTable))
	vResponse:="Table not valid: "+$tableName
	//vMimeType:="text/html"
Else 
	$ptField:=STR_GetFieldPointer($tableName; "obGeneral")
	If (Is nil pointer:C315($ptField))
		vResponse:="ObGeneral is not valid: "+$tableName
		//vMimeType:="text/html"
	Else 
		ARRAY TEXT:C222($atKeyWord; 0)
		GET TEXT KEYWORDS:C1141($vtKeyword; $atKeyWord)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274($atKeyWord)
		Case of 
			: ($k>2)
				$k:=$k-1
				QUERY BY ATTRIBUTE:C1331($ptTable->; $ptField->; "keyTags"; %; $atKeyWord{1}+"@"; *)
				For ($i; 2; $k)
					QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptField->; "keyTags"; %; $atKeyWord{$i}+"@"; *)
				End for 
				QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptField->; "keyTags"; %; $atKeyWord{$k+1}+"@")
			: ($k=2)
				QUERY BY ATTRIBUTE:C1331($ptTable->; $ptField->; "keyTags"; %; $atKeyWord{1}+"@"; *)
				QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptField->; "keyTags"; %; $atKeyWord{2}+"@")
			Else 
				QUERY BY ATTRIBUTE:C1331($ptTable->; $ptField->; "keyTags"; %; $vtKeyWord+"@")
		End case 
	End if 
End if 