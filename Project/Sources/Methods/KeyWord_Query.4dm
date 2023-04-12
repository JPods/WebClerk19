//%attributes = {}

// Modified by: Bill James (2022-06-29T05:00:00Z)
// Method: KeyWord_Query
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($dataClassName : Text; $vtKeyword : Text; $range : Text; $entsInSelection : Object)->$ents : Object
//If (((Form event code=On Data Change) | \
(Form event code=On After Keystroke))\
 & (Length($queryRequest)>1))  // add timer

$vtKeyword:=KeyWordCleanup($vtKeyword)

var $dataClass : Object
var $fieldToQuery : Text
$dataClass:=ds:C1482[$dataClassName]
If ($dataClass=Null:C1517)
	vResponse:="Table not valid: "+$dataClassName
	//vMimeType:="text/html"
Else 
	Case of 
		: ($dataClass.keyTags#Null:C1517)
			vResponse:="Query keyTags"
			//$ptKeyTagsField:=STR_GetFieldPointer($dataClassName; "keyTags")
			$fieldToQuery:="keyTags"
		: ($dataClass.obGeneral#Null:C1517)
			vResponse:="Query obGeneral"
			$fieldToQuery:="obGeneral.keyTags"
			//$ptObjField:=STR_GetFieldPointer($dataClassName; "obGeneral")
		Else 
			vResponse:="No ObGeneral or KeyTags field available: "+$dataClassName
	End case 
End if 
If (vResponse="Query@")
	var $word; $queryString : Text
	var $cParameters : Collection
	$cParameters:=Split string:C1554($vtKeyword; ";")
	
	var $cnt : Integer
	For each ($word; $cParameters)
		$queryString:=$queryString+$fieldToQuery+" = :"+String:C10($cnt+1)+" and "
		//$cParameters[$cnt]:="%"+$cParameters[$cnt]+"@"
		$cParameters[$cnt]:="@"+$cParameters[$cnt]+"@"
		$cnt:=$cnt+1
	End for each 
	var $queryParams : Object
	$queryParams:=New object:C1471("parameters"; $cParameters)
	$queryString:=Substring:C12($queryString; 1; Length:C16($queryString)-5)
	
	If ($inSelection)
		$ents:=$entsInSelection.query($queryString; $queryParams)
	Else 
		$ents:=ds:C1482[$dataClassName].query($queryString; $queryParams)
	End if 
	
	
	
	//C_LONGINT($i; $k)
	//$k:=Size of array($atKeyWord)
	//Case of 
	//: (vResponse="Query KeyTags")
	
	
	
	//Case of 
	//: ($k>2)
	//$k:=$k-1
	//QUERY($ptTable->; $ptKeyTagsField->%$atKeyWord{1}+"@"; *)
	//For ($i; 2; $k)
	//QUERY($ptTable->;  & ; $ptKeyTagsField->%$atKeyWord{$i}+"@"; *)
	//End for 
	//QUERY($ptTable->;  & ; $ptKeyTagsField->%$atKeyWord{$k+1}+"@")
	//: ($k=2)
	//QUERY($ptTable->; $ptKeyTagsField->%$atKeyWord{1}+"@"; *)
	//QUERY($ptTable->;  & ; $ptKeyTagsField->%$atKeyWord{2}+"@")
	//Else 
	//QUERY($ptTable->; $ptKeyTagsField->%$vtKeyWord+"@")
	//End case 
	
	//: (vResponse="Query ObGeneral")
	////  KeywordByObject
	
	//If (<>vtQueryBy="contains")
	//Case of 
	//: ($k>2)
	//$k:=$k-1
	//QUERY BY ATTRIBUTE($ptTable->; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{1}+"@"; *)
	//For ($i; 2; $k)
	//QUERY BY ATTRIBUTE($ptTable->;  & ; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{$i}+"@"; *)
	//End for 
	//QUERY BY ATTRIBUTE($ptTable->;  & ; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{$k+1}+"@")
	
	//: ($k=2)
	//QUERY BY ATTRIBUTE($ptTable->; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{1}+"@"; *)
	//QUERY BY ATTRIBUTE($ptTable->;  & ; $ptObjField->; "keyTags"; =; "@"+$atKeyWord{2}+"@")
	//Else 
	//QUERY BY ATTRIBUTE($ptTable->; $ptObjField->; "keyTags"; =; "@"+$vtKeyWord+"@")
	//End case 
	//Else 
	//Case of 
	//: ($k>2)
	//$k:=$k-1
	//QUERY BY ATTRIBUTE($ptTable->; $ptObjField->; "keyTags"; %; $atKeyWord{1}; *)
	//For ($i; 2; $k)
	//QUERY BY ATTRIBUTE($ptTable->;  & ; $ptObjField->; "keyTags"; %; $atKeyWord{$i}; *)
	//End for 
	//QUERY BY ATTRIBUTE($ptTable->;  & ; $ptObjField->; "keyTags"; %; $atKeyWord{$k+1})
	
	//: ($k=2)
	//QUERY BY ATTRIBUTE($ptTable->; $ptObjField->; "keyTags"; %; $atKeyWord{1}; *)
	//QUERY BY ATTRIBUTE($ptTable->;  & ; $ptObjField->; "keyTags"; %; $atKeyWord{2})
	//Else 
	//QUERY BY ATTRIBUTE($ptTable->; $ptObjField->; "keyTags"; %; $vtKeyWord)
	//End case 
	
	//End if 
	//End case 
End if 