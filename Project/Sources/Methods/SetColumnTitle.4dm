//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/21/19, 18:55:42
// ----------------------------------------------------
// Method: SetColumnTitle
// Description
// 
//
// Parameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

C_TEXT:C284($vtField; $vtFieldName; $vtNumber; $vtText)
C_POINTER:C301($vpField)

//==================================
//  Initialize variables 
//==================================

$vtField:=""
$vtFieldName:=""
$vtNumber:=""
$vtText:=""
//</declarations>

$vtNumber:=String:C10(Num:C11(OBJECT Get name:C1087(Object current:K67:2)))
$vtField:="Field_"+$vtNumber
$vtText:="Text_"+$vtNumber
$vpField:=OBJECT Get data source:C1265(*; $vtField)
If (Is a variable:C294($vpField))
	// Do not change Title of a variable
Else 
	$vtFieldName:=Field name:C257($vpField)
	OBJECT SET TITLE:C194(*; $vtText; $vtFieldName)
End if 

// set format
SelectSortFormat($vtFieldName; $vtField; $vpField)
