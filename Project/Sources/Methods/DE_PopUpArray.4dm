//%attributes = {}

// Modified by: Bill James (2022-03-30T05:00:00Z)
// Method: DE_PopUpArray
// Description 
// Parameters
// ----------------------------------------------------

// Replaced:  jPopUpArray

//Procedure: jPopUpArray
//Friday, May 1, 1998 / 8:59:30 PM
C_POINTER:C301($1; $ptPopup; $ptField)
var $0 : Text
C_TEXT:C284($vtValue; $vtArrayName; $text)
C_LONGINT:C283($i; viTableNum; viFieldNum)
$ptPopup:=$1
If ($ptPopup->>1)
	$0:=$ptPopup->{$ptPopup->}
End if 
$ptPopup->:=1