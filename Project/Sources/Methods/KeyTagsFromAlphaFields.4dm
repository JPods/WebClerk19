//%attributes = {}

// Modified by: Bill James (2021-11-15T06:00:00Z)
// Method: KeyTagsFromAlphaFields
// Description 
// Parameters
// ----------------------------------------------------
var $1; $rec_ent; $dataClass_o : Object
var $0; $2; $tableName; $fieldName; $word; $protectedWords : Text
var $tags_c; $clean_c; $temp_c : Collection
$tags_c:=New collection:C1472
$clean_c:=New collection:C1472

If ($1=Null:C1517)
	If (voState.urlOriginal=Null:C1517)
		$0:="Error, null passed to KeyTagsFromAlphaFields, voState.urlOriginal is null"
	Else 
		$0:="Error, null passed to KeyTagsFromAlphaFields, voState.urlOriginal: "+voState.urlOriginal
	End if 
	ConsoleMessage($0)
Else 
	$rec_ent:=$1
	If (Count parameters:C259=2)
		$tableName:=$2
	End if 
	$dataClass_o:=$rec_ent.getDataClass()
	$tableName:=$dataClass_o.getInfo().name
	
	DE_obGeneralTest($rec_ent)
	
	//$protectedWords
	If ($rec_ent.obGeneral.keyText#"")
		$cleaned:=Replace string:C233($rec_ent.obGeneral.keyText; ", "; ",")
		$cleaned:=Replace string:C233($cleaned; "; "; ",")
		$cleaned:=Replace string:C233($cleaned; ";"; ",")
		$cleaned:=Replace string:C233($cleaned; " "; ",")
		$tags_c:=Split string:C1554($cleaned; ",")
		$tags_c:=$tags_c.distinct()
		$rec_ent.obGeneral.keyText:=$tags_c.join(",")
	End if 
	
	For each ($fieldName; $dataClass_o)
		If ($dataClass_o[$fieldName].fieldType=0)
			If ($rec_ent[$fieldName]#Null:C1517)
				$cleaned:=Replace string:C233($rec_ent[$fieldName]; ", "; ",")
				$cleaned:=Replace string:C233($cleaned; " "; ",")
				$temp_c:=Split string:C1554($cleaned; ",")
				$temp_c:=$temp_c.distinct()
				For each ($word; $temp_c)
					If (Length:C16($word)>1)
						$tags_c.push($word)
					End if 
				End for each 
			End if 
		End if 
	End for each 
	
	$rec_ent.obGeneral.keyTags:=$tags_c.distinct().join(",")
	
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; "\t"; "")
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; "\n"; "")
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; "\r"; "")
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; ":"; "")
	$0:=$rec_ent.obGeneral.keyTags
	
	$rec_ent.obGeneral.ktbackup:=$rec_ent.obGeneral.keyTags
	If ($rec_ent.keyTags#Null:C1517)
		$rec_ent.keyTags:=$rec_ent.obGeneral.keyTags
	End if 
	$rec_ent.save()
End if 