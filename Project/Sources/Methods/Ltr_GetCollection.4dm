//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/19/21, 13:18:40
// ----------------------------------------------------
// Method: Ltr_GetCollection
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($viLetterTableNum)
C_COLLECTION:C1488($0; $cLetters)
$viLetterTableNum:=STR_GetTableNumber($1)
$cLetters:=New collection:C1472
$obSel:=ds:C1482.Letter.query("tableNum = :1 AND active = :2"; $viLetterTableNum; True:C214)
$cFilter:=Split string:C1554("name,topic,body,id,securityLevel"; ";")
$cLetters:=$obSel.toCollection($cFilter)
$0:=$cLetters

