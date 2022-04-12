//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 03/29/18, 14:08:42
// ----------------------------------------------------
// Method: String_ContainKeyword
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($0; $vbContainsKeyword)
$vbContainsKeyword:=False:C215

C_TEXT:C284($1; $vtString)
$vtString:=$1

C_TEXT:C284($2; $vtKeyword)
$vtKeyword:=$2

C_COLLECTION:C1488($vcKeywords)
$vcKeywords:=Split string:C1554($vtString; " ")

If ($vcKeywords.indexOf($vtKeyword)>-1)
	$vbContainsKeyword:=True:C214
End if 

// RETURN THE VALUE

$0:=$vbContainsKeyword
