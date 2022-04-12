//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/13/18, 17:14:13
// ----------------------------------------------------
// Method: GetFieldPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------


//<declarations>
//==================================
//  Type variables 
//==================================

C_LONGINT:C283($viBracketClose; $viBracketOpen; $viField; $viFieldLength; $viFieldStart; $viIndex)
C_LONGINT:C283($viStartTableName; $viTable; $viTableLength; $viTableStart)
C_TEXT:C284($vtField; $vtName; $vtTable; $1)
C_POINTER:C301($vpTable; vpNIL)

//==================================
//  Initialize variables 
//==================================

$viBracketClose:=0
$viBracketOpen:=0
$viField:=0
$viFieldLength:=0
$viFieldStart:=0
$viIndex:=0
$viStartTableName:=0
$viTable:=0
$viTableLength:=0
$viTableStart:=0
$vtField:=""
$vtName:=""
$vtTable:=""
//</declarations>

$vtName:=$1

$viBracketOpen:=Position:C15("["; $vtName)
$viBracketClose:=Position:C15("]"; $vtName)
$viTableStart:=$viBracketOpen+1
$viTableLength:=$viBracketClose-$viTableStart
$viFieldStart:=$viBracketClose+1
$viFieldLength:=Length:C16($vtName)-$viBracketClose

$vtTable:=Substring:C12($vtName; $viTableStart; $viTableLength)
$vtField:=Substring:C12($vtName; $viFieldStart; $viFieldLength)

$viIndex:=Find in array:C230(<>aTableNames; $vtTable)

If ($viIndex>0)
	$viTable:=<>aTableNums{$viIndex}
	$vpTable:=Table:C252($viTable)
	
	ARRAY TEXT:C222($atFieldNames; Get last field number:C255($vpTable))
	ARRAY POINTER:C280($apFields; Get last field number:C255($vpTable))
	For ($viField; Size of array:C274($atFieldNames); 1; -1)
		If (Is field number valid:C1000($viTable; $viField))
			$atFieldNames{$viField}:=Field name:C257($viTable; $viField)
			$apFields{$viField}:=Field:C253($viTable; $viField)
		Else 
			DELETE FROM ARRAY:C228($atFieldNames; $viField)
			DELETE FROM ARRAY:C228($apFields; $viField)
		End if 
	End for 
	
	// sort list a-z
	SORT ARRAY:C229($atFieldNames; $apFields; >)
	
	$viIndex:=Find in array:C230($atFieldNames; $vtField)
	
End if 

If ($viIndex>0)
	$0:=$apFields{$viIndex}
Else 
	$0:=vpNIL
End if 
