//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 23:34:35
// ----------------------------------------------------
// Method: SE_TextFromSelectedFields
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($ptArray; $1; $ptSelected; $2)
C_LONGINT:C283($incRay; $cntRay)
C_TEXT:C284($vtFieldList; $0)
$ptArray:=$1
$ptSelected:=$2
$cntRay:=Size of array:C274($ptSelected->)
For ($incRay; 1; $cntRay)
	$vtFieldList:=$vtFieldList+$ptArray->{$ptSelected->{$incRay}}+","
End for 
$0:=Substring:C12($vtFieldList; 1; Length:C16($vtFieldList)-1)
