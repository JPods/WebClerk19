//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/16/20, 22:03:13
// ----------------------------------------------------
// Method: KeyWordByTag
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($viMilli; $ivRecords)
If (<>VIDEBUGMODE>=410)
	$viMilli:=Milliseconds:C459
End if 
C_OBJECT:C1216($obSel)
C_TEXT:C284($1; $2; $tableName; $vtKeyword; $vtFieldName)
C_POINTER:C301($ptTable; $ptKeyTagsField; $ptObjField; $ptField)
$tableName:=$1
$vtKeyword:=$2
$obSel:=ds:C1482[$tableName].new()
If ($obSel=Null:C1517)
	vResponse:="Table not valid: "+$tableName
	//vMimeType:="text/html"
Else 
	$ptTable:=STR_GetTablePointer($tableName)
	$ptKeyTagsField:=STR_GetFieldPointer($tableName; "keyTags")
	If (Is nil pointer:C315($ptKeyTagsField))
		$ptObjField:=STR_GetFieldPointer($tableName; "obGeneral")
		If (Is nil pointer:C315($ptObjField))
			vResponse:="No ObGeneral or KeyTags field available: "+$tableName
		Else 
			vResponse:="Query obGeneral"
		End if 
	Else 
		vResponse:="Query keyTags"
	End if 
End if 
If (vResponse="Query@")
	ARRAY TEXT:C222($atKeyWord; 0)
	GET TEXT KEYWORDS:C1141($vtKeyword; $atKeyWord)
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274($atKeyWord)
	Case of 
		: (vResponse="Query KeyTags")
			If (<>vtQueryBy="contains")
				Case of 
					: ($k>2)
						$k:=$k-1
						QUERY:C277($ptTable->; $ptKeyTagsField->="@"+$atKeyWord{1}+"@"; *)
						For ($i; 2; $k)
							QUERY:C277($ptTable->;  & ; $ptKeyTagsField->="@"+$atKeyWord{$i}+"@"; *)
						End for 
						QUERY:C277($ptTable->;  & ; $ptKeyTagsField->="@"+$atKeyWord{$k+1}+"@")
					: ($k=2)
						QUERY:C277($ptTable->; $ptKeyTagsField->="@"+$atKeyWord{1}+"@"; *)
						QUERY:C277($ptTable->;  & ; $ptKeyTagsField->="@"+$atKeyWord{2}+"@")
					Else 
						QUERY:C277($ptTable->; $ptKeyTagsField->="@"+$vtKeyWord+"@")
				End case 
				
			Else 
				Case of 
					: ($k>2)
						$k:=$k-1
						QUERY:C277($ptTable->; $ptKeyTagsField->%$atKeyWord{1}+"@"; *)
						For ($i; 2; $k)
							QUERY:C277($ptTable->;  & ; $ptKeyTagsField->%$atKeyWord{$i}+"@"; *)
						End for 
						QUERY:C277($ptTable->;  & ; $ptKeyTagsField->%$atKeyWord{$k+1}+"@")
					: ($k=2)
						QUERY:C277($ptTable->; $ptKeyTagsField->%$atKeyWord{1}+"@"; *)
						QUERY:C277($ptTable->;  & ; $ptKeyTagsField->%$atKeyWord{2}+"@")
					Else 
						QUERY:C277($ptTable->; $ptKeyTagsField->%$vtKeyWord+"@")
				End case 
			End if 
		: (vResponse="Query ObGeneral")
			//  KeywordByObject
			
			If (<>vtQueryBy="contains")
				Case of 
					: ($k>2)
						$k:=$k-1
						QUERY BY ATTRIBUTE:C1331($ptTable->; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{1}+"@"; *)
						For ($i; 2; $k)
							QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{$i}+"@"; *)
						End for 
						QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{$k+1}+"@")
						
					: ($k=2)
						QUERY BY ATTRIBUTE:C1331($ptTable->; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{1}+"@"; *)
						QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{2}+"@")
					Else 
						QUERY BY ATTRIBUTE:C1331($ptTable->; $ptObjField->; "keyTags"; =; "@"+$vtKeyWord+"@")
				End case 
			Else 
				Case of 
					: ($k>2)
						$k:=$k-1
						QUERY BY ATTRIBUTE:C1331($ptTable->; $ptObjField->; "keyTags"; %; $atKeyWord{1}; *)
						For ($i; 2; $k)
							QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptObjField->; "keyTags"; %; $atKeyWord{$i}; *)
						End for 
						QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptObjField->; "keyTags"; %; $atKeyWord{$k+1})
						
					: ($k=2)
						QUERY BY ATTRIBUTE:C1331($ptTable->; $ptObjField->; "keyTags"; %; $atKeyWord{1}; *)
						QUERY BY ATTRIBUTE:C1331($ptTable->;  & ; $ptObjField->; "keyTags"; %; $atKeyWord{2})
					Else 
						QUERY BY ATTRIBUTE:C1331($ptTable->; $ptObjField->; "keyTags"; %; $vtKeyWord)
				End case 
				
			End if 
	End case 
End if 


