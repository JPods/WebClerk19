//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/13/17, 11:34:17
// ----------------------------------------------------
// Method: WildcardFindInArray
//
// Description:
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************* //
// ****** TYPE AND INITIALIZE PARAMETERS ***** //
// ******************************************* //

// RETURN VARIABLE
C_LONGINT:C283($0; $viMatchIndex)
$viMatchIndex:=-1

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_POINTER:C301($1; $vpHaystack)
$vpHaystack:=$1

// PARAMETER 2 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($2; $vtNeedle)
$vtNeedle:=$2

// PARAMETER 2 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_LONGINT:C283($viCounter)
$viCounter:=1

// ******************************************* //
// ******** LOOP THROUGH THE HAYSTACK ******** //
// ******************************************* //

For ($viCounter; 1; Size of array:C274($vpHaystack->))
	
	If ($vtNeedle=$vpHaystack->{$viCounter})
		
		$viMatchIndex:=$viCounter
		
	End if 
	
End for 

// ******************************************* //
// ********** RETURN THE MATCH INDEX ********* //
// ******************************************* //

$0:=$viMatchIndex