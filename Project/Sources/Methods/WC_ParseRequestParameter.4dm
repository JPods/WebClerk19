//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-16T00:00:00, 00:32:15
// ----------------------------------------------------
// Method: WC_ParseRequestParameter
// Description
// Modified: 10/16/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($httpBody : Text)->$result : Object



// Clear the arrays for the request parameters
ARRAY TEXT:C222(aParameterName; 0)
ARRAY TEXT:C222(aParameterValue; 0)
$voParameters:=New object:C1471

If (vWCPayload="{@")
	// ### bj ### 20201215_0901
	// put a Post into voState.request.parameters
	$voParameters:=JSON Parse:C1218(vWCPayload)
	// ObjectToArrays ($voParameters;->aParameterName;->aParameterValue)
Else 
	// put a Get into voState.request.parameters
	ARRAY TEXT:C222($items; 0)
	ARRAY TEXT:C222($tokens; 0)
	
	// Split into items
	String_Split(vWCPayload; "&"; ->$items)
	
	// Split each item into tokens
	C_LONGINT:C283($itemCnt)
	$itemCnt:=Size of array:C274($items)
	For ($itemNr; 1; $itemCnt)
		String_Split($items{$itemNr}; "="; ->$tokens; True:C214)  // ### AZM ### 20180213 USE 4TH PARAMETER TO HAVE THE METHOD WATCH FOR TRAILING DELIMITERS
		If (Size of array:C274($tokens)>=2)
			APPEND TO ARRAY:C911(aParameterName; URL_Decode($tokens{1}))
			APPEND TO ARRAY:C911(aParameterValue; URL_Decode($tokens{2}))
			$sizeParaName:=Size of array:C274(aParameterName)
		End if 
	End for 
	
	For ($viCounter; 1; Size of array:C274(aParameterName))
		$voParameters[aParameterName{$viCounter}]:=aParameterValue{$viCounter}
	End for 
	
End if 

$result:=$voParameters