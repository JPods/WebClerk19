//%attributes = {}

// Modified by: Bill James (2021-11-15T06:00:00Z)
// Method: KeyTagsFromAlphaFields
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($rec_ent : Object; $tableName : Text; $doSave : Boolean)->$keyTags_t : Text
var $1; $rec_ent; $dataClass_o : Object
var $keyTags_t; $tableName; $fieldName; $word; $protectedWords : Text

If (Count parameters:C259<3)
	$doSave:=True:C214
End if 

var $tags_c; $clean_c; $temp_c : Collection
$tags_c:=New collection:C1472
$clean_c:=New collection:C1472

If ($rec_ent=Null:C1517)
	If (voState.urlOriginal=Null:C1517)
		$keyTags_t:="Error, null passed to KeyTagsFromAlphaFields, voState.urlOriginal is null"
	Else 
		$keyTags_t:="Error, null passed to KeyTagsFromAlphaFields, voState.urlOriginal: "+voState.urlOriginal
	End if 
	ConsoleLog($keyTags_t)
Else 
	$dataClass_o:=$rec_ent.getDataClass()
	$tableName:=$dataClass_o.getInfo().name
	
	DE_obGeneralTest($rec_ent)
	
	//$protectedWords
	// Modified by: Bill James (2023-01-14T06:00:00Z)
	// ; ", "; ";")
	If ($rec_ent.obGeneral.keyText#"")
		$cleaned:=Replace string:C233($rec_ent.obGeneral.keyText; ", "; ";")
		$cleaned:=Replace string:C233($cleaned; ","; ";")
		$cleaned:=Replace string:C233($cleaned; "; "; ";")
		$cleaned:=Replace string:C233($cleaned; " "; ";")
		$tags_c:=Split string:C1554($cleaned; ";")
		$tags_c:=$tags_c.distinct()
		$rec_ent.obGeneral.keyText:=$tags_c.join(";")
	End if 
	
	For each ($fieldName; $dataClass_o)
		Case of 
			: ($fieldName="id")
				// skip UUIDkey for now. I do not think people will query it as a general item
			: ($dataClass_o[$fieldName].fieldType=0)
				If ($rec_ent[$fieldName]#Null:C1517)
					$cleaned:=Replace string:C233($rec_ent[$fieldName]; ", "; ",")
					$cleaned:=Replace string:C233($cleaned; " "; ",")
					$temp_c:=Split string:C1554($cleaned; ";")
					$temp_c:=$temp_c.distinct()
					For each ($word; $temp_c)
						If (Length:C16($word)>1)
							$tags_c.push($word)
						End if 
					End for each 
				End if 
		End case 
	End for each 
	
	$rec_ent.obGeneral.keyTags:=$tags_c.distinct().join(";")
	
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; "\t"; "")
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; "\n"; "")
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; "\r"; "")
	$rec_ent.obGeneral.keyTags:=Replace string:C233($rec_ent.obGeneral.keyTags; ":"; "")
	$keyTags_t:=$rec_ent.obGeneral.keyTags
	
	$rec_ent.obGeneral.ktbackup:=$rec_ent.obGeneral.keyTags
	If ($rec_ent.keyTags#Null:C1517)
		$rec_ent.keyTags:=$rec_ent.obGeneral.keyTags
	End if 
	If ($doSave)
		$result:=$rec_ent.save()
	End if 
End if 