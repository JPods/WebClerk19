//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/29/17, 08:37:24
// ----------------------------------------------------
// Method: PageSetParameter
//
// Description:
//
// This method is set the name of an HTTP query parameter,
// and a value, and it sets that parameter in the global
// cache. This newly set parameter behaves as if it was sent
// by the user, and can be accessed via WCapi_GetParameter.
//
// This method is necesary because in many methods, we can't
// pass in a method defined override for jitPageOne. The methods
// only allow overrides through HTTP query parameters.
//
// Parameters:
//
// $1 - String - The query parameter name.
// $2 - String - The query parameter value.
// 
// Return:
//
// $0 - No return
// ----------------------------------------------------

// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

C_TEXT:C284($1; $vtParameterName)
$vtParameterName:=$1

C_TEXT:C284($2; $vtParameterValue)
$vtParameterValue:=$2

C_BOOLEAN:C305($3; $vbOverride)
If (Count parameters:C259>2)
	$vbOverride:=$3
Else 
	$vbOverride:=False:C215
End if 

// ******************************************* //
// ****** UPDATE OR ADD THE QUERY VALUE ****** //
// ******************************************* //

// CHECK TO SEE IF QUERY PARMETER HAS ALREADY BEEN SET.
// WE DON'T WANT TO OVERWRITE A REAL HTTP PARAMETER IF
// IT EXISTS.

$p:=Find in array:C230(aParameterName; $vtParameterName)

If ($p<1)
	
	// ADD THE NEW KEY/VALUE PAIR
	
	APPEND TO ARRAY:C911(aParameterName; $vtParameterName)
	APPEND TO ARRAY:C911(aParameterValue; $vtParameterValue)
	
Else 
	
	If ($vbOverride=True:C214)
		
		aParameterValue{$p}:=$vtParameterValue
		
	End if 
	
End if 