//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/18/20, 22:43:50
// ----------------------------------------------------
// Method: Key_SubtractWord
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
		Key_SubtractWord($ptTable)
		NEXT RECORD:C51($ptTable->)
	End for 
Else 
	$tableName:=Table name:C256($ptTable)
	$ptFieldOb:=STR_GetFieldPointer($tableName; "obGeneral")
	$vtTags:=""
	If (OB Is defined:C1231($ptFieldOb->; "keytext"))
		$vtTags:=OB Get:C1224($ptFieldOb->; "keytext")
	End if 
	
	ARRAY TEXT:C222($aKeys; 0)
	ARRAY TEXT:C222($aRemove; 0)
	GET TEXT KEYWORDS:C1141($vtTags; $aKeys; *)
	GET TEXT KEYWORDS:C1141(srKeyword; $aRemove; *)  //Unique words
	
	C_LONGINT:C283($incWord; $cntWord; $found)
	$cntWord:=Size of array:C274($aRemove)
	For ($incWord; $cntWord; 1; -1)
		$found:=Find in array:C230($aKeys; $aRemove{$incWord})
		If ($found>0)
			DELETE FROM ARRAY:C228($aKeys; $found; 1)
		End if 
	End for 
	
	C_TEXT:C284($vtCleaned)
	$vtCleaned:=""
	$cntWord:=Size of array:C274($aKeys)
	For ($incWord; 1; $cntWord)
		$vtCleaned:=$vtCleaned+$aKeys{$incWord}+","
	End for 
	$viLen:=Length:C16($vtCleaned)
	If ($viLen>0)
		$vtCleaned:=Substring:C12($vtCleaned; 1; $viLen-1)
	End if 
	
	OB SET:C1220($ptFieldOb->; "keytext"; $vtCleaned)
	
	$ptFieldText:=STR_GetFieldPointer($tableName; "keytext")
	If (Not:C34(Is nil pointer:C315($ptFieldText)))
		$ptFieldText->:=$vtCleaned
	End if 
	SAVE RECORD:C53($ptTable->)
	KeyWordsMake($ptTable)
End if 