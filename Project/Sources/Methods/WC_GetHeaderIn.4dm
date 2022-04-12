//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/07/21, 20:46:27
// ----------------------------------------------------
// Method: WC_GetHeaderIn
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $0)

C_LONGINT:C283($index)
$index:=Find in array:C230(aHeaderNameIn; $1)
$0:=""
If ($index>0)
	$0:=aHeaderValueIn{$index}
End if 