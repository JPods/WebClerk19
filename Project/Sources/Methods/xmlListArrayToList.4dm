//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/22/10, 15:37:56
// ----------------------------------------------------
// Method: xmlListArrayToList
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2)

$arrayPtr:=$1
$listPtr:=$2

For ($i; 1; Size of array:C274($arrayPtr->))
	Case of 
			//handle non-text types here...
		Else 
			APPEND TO LIST:C376($listPtr->; $arrayPtr->{$i}; 0)
	End case 
End for 
