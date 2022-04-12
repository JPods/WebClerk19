//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 03/29/18, 14:08:42
// ----------------------------------------------------
// Method: String_AddKeyword
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtString)
$vtString:=$1

C_TEXT:C284($2; $vtKeyword)
$vtKeyword:=$2

// COPY FIRST CHARACTER AND SET IT TO UPPERCASE

C_COLLECTION:C1488($vcKeywords)
$vcKeywords:=Split string:C1554($vtString; " ")

If ($vcKeywords.indexOf($vtKeyword)=-1)
	$vcKeywords.push($vtKeyword)
End if 

$vtString:=$vcKeywords.join(" ")

// RETURN THE VALUE

$0:=$vtString
