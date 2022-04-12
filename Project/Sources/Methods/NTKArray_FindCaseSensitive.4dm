//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 08:59:31
// ----------------------------------------------------
// Method: NTKArray_FindCaseSensitive
// Description
// 
//
// Parameters
// ----------------------------------------------------

// (PM) ARRAY_FindCaseSensitive
// Performs a case-sensitive find in array
// $1 = Pointer to array
// $2 = Value to find
// $3 = Start position (optional)
// $0 = Found position

C_POINTER:C301($1; $array)
C_TEXT:C284($2; $value)
C_LONGINT:C283($3; $offset)
C_LONGINT:C283($0; $found)
C_BOOLEAN:C305($continue)

$array:=$1
$value:=$2
If (Count parameters:C259>=3)
	$offset:=$3
Else 
	$offset:=1
End if 

$continue:=True:C214

While ($continue)
	
	$found:=Find in array:C230($array->; $value; $offset)
	Case of 
		: ($found=-1)
			$continue:=False:C215
		: (NTKString_CaseCompare($array->{$found}; $value))
			$continue:=False:C215
		Else 
			$offset:=$found+1
	End case 
	
End while 

$0:=$found