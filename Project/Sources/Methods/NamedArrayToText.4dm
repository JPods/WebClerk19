//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-02T00:00:00, 01:14:06
// ----------------------------------------------------
// Method: NamedArrayToText
// Description
// Modified: 01/02/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptToArray; $2; $ptToText)
$ptToArray:=$1
$ptToText:=$2


C_TEXT:C284($selectionList)
C_LONGINT:C283($cntRecord; $incRecords)
$cntRecords:=Size of array:C274($ptToArray->)
$ptToText->:=String:C10($ptToArray->{1})
For ($incRecords; 2; $cntRecords)
	$ptToText->:=$ptToText->+"\t"+String:C10($ptToArray->{$incRecords})
End for 