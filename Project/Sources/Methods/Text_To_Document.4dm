//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/05/20, 12:28:15
// ----------------------------------------------------
// Method: Text_To_Document
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $vtDocPath; $vtData)
$vtData:=$2
$vtDocPath:=$1
TEXT TO DOCUMENT:C1237($vtDocPath; $vtData)