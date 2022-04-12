//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-22T00:00:00, 22:54:26
// ----------------------------------------------------
// Method: Key_CreateRecord
// Description
// Modified: 08/22/13
// 
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptKey; $ptTable)
C_TEXT:C284($2; $3; $keyWord; $keyRef)
C_LONGINT:C283($tablenum; $fieldnum; $fieldType; $count)

$ptKey:=$1  // pointer to 
$fieldType:=Type:C295($1->)
$dtlastupdated:=0
If (Count parameters:C259<2)
	// skip
Else 
	$keyWord:=$2
	If (Count parameters:C259>2)
		$keyRef:=$3
	End if 
	Case of 
		: (Is nil pointer:C315($1))
			$tablenum:=-1
			$fieldnum:=-1
		: (($fieldType=Is longint:K8:6) | ($fieldType=Is alpha field:K8:1))
			$tablenum:=Table:C252($1)
			$ptTable:=Table:C252($tablenum)
			$fieldnum:=Field:C253($1)
		Else 
			$tablenum:=-1
			$fieldnum:=-1
	End case 
	
	CREATE RECORD:C68([Word:99])
	
	[Word:99]tableNum:2:=$tablenum
	[Word:99]fieldNum:7:=$fieldnum
	If ($fieldType=Is longint:K8:6)
		[Word:99]relatedLongInt:9:=$ptKey->
	Else 
		[Word:99]relatedAlpha:8:=$ptKey->
	End if 
	[Word:99]wordOnly:3:=$keyWord
	[Word:99]reference:6:=$keyRef
	If (([Word:99]wordOnly:3#"") & ([Word:99]reference:6#""))
		[Word:99]wordCombined:5:=[Word:99]wordOnly:3+"_"+[Word:99]reference:6
	Else 
		[Word:99]wordCombined:5:=[Word:99]wordOnly:3+[Word:99]reference:6
	End if 
	
	SAVE RECORD:C53([Word:99])
End if 