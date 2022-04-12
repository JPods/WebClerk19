//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/24/21, 01:48:38
// ----------------------------------------------------
// Method: Cat_BuildLine
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1; $voLines; $0; $voTest)
// C_COLLECTION(
$voTest:=New object:C1471
$voLines:=$1
$0:=$voLines
$voTest.lines:=$voLines
C_TEXT:C284($vtLines)
$vtLines:=JSON Stringify array:C1228($voLines)