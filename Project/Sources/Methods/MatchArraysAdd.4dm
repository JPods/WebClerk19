//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/27/18, 22:26:28
// ----------------------------------------------------
// Method: MatchArraysAdd
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ARRAY TEXT(theFields;0)
// ARRAY TEXT(theTypes;0)
// ARRAY TEXT(theUniques;0)
// ARRAY LONGINT(theFldNum;0)

// ARRAY TEXT(aMatchField;0)
// ARRAY TEXT(aMatchType;0)
// ARRAY Longint(aMatchNum;0)
// ARRAY Longint(aCntMatFlds;0)

C_LONGINT:C283($1; $tableNum; $2; $fieldNum)

C_LONGINT:C283($3; $action; $w)

$tableNum:=$1
$fieldNum:=$2
$action:=0

If (Count parameters:C259>2)
	$action:=$3
End if 

Case of 
	: ($action=0)  // "append"
		If ($fieldNum<1)
			APPEND TO ARRAY:C911(aMatchNum; -2)
			APPEND TO ARRAY:C911(aMatchType; "*")
			APPEND TO ARRAY:C911(aMatchField; "NOT IMPORTED")
		Else 
			$w:=Find in array:C230(theFldNum; $fieldNum)
			APPEND TO ARRAY:C911(aMatchNum; theFldNum{$w})
			APPEND TO ARRAY:C911(aMatchType; theTypes{$w})
			APPEND TO ARRAY:C911(aMatchField; theFields{$w})
		End if 
	: ($action>0)  // "insert"
		INSERT IN ARRAY:C227(aMatchNum; $action; 1)
		INSERT IN ARRAY:C227(aMatchField; $action; 1)  // ;theFields{aFieldLns{$1}})
		INSERT IN ARRAY:C227(aMatchType; $action; 1)  // ;theTypes{aFieldLns{$1}})
		If ($fieldNum<1)
			aMatchNum{$action}:=-2
			aMatchType{$action}:="*"
			aMatchField{$action}:="NOT IMPORTED"
		Else 
			$w:=Find in array:C230(theFldNum; $fieldNum)
			aMatchNum{$action}:=theFldNum{$w}
			aMatchType{$action}:=theTypes{$w}
			aMatchField{$action}:=theFields{$w}
		End if 
End case 
