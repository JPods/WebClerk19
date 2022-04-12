//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/16/20, 23:03:02
// ----------------------------------------------------
// Method: Key_AddWord
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable)
C_TEXT:C284($2; $vtSelection; $tableName)

$ptTable:=$1
If (Count parameters:C259>1)
	$vtSelection:=$2
	If (Count parameters:C259>2)
		srKeyword:=$3
	End if 
End if 

If ($vtSelection="selection")
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76($ptTable->)
	FIRST RECORD:C50($ptTable->)
	For ($i; 1; $k)
		Key_AddWord($ptTable)
		NEXT RECORD:C51($ptTable->)
	End for 
Else 
	$tableName:=Table name:C256($ptTable)
	$ptFieldOb:=STR_GetFieldPointer($tableName; "obGeneral")
	$vtTags:=""
	If (OB Is defined:C1231($ptFieldOb->; "keytext"))
		$vtTags:=OB Get:C1224($ptFieldOb->; "keytext")
	End if 
	$vtKeys:=KeyWordCleanup($vtTags+","+srKeyword)
	OB SET:C1220($ptFieldOb->; "keytext"; $vtKeys)
	
	$ptFieldText:=STR_GetFieldPointer($tableName; "keytext")
	If (Not:C34(Is nil pointer:C315($ptFieldText)))
		$ptFieldText->:=$vtKeys
	End if 
	SAVE RECORD:C53($ptTable->)
	KeyWordsMake($ptTable)
	SAVE RECORD:C53($ptTable->)
	
End if 