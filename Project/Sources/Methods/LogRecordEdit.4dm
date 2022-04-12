//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 01/04/18, 15:13:17
// ----------------------------------------------------
// Method: LogRecordEdit
// Description
// 
//
// Parameters
// ----------------------------------------------------

// TYPICAL USAGE:
// LogRecordEdit("Customer";"115485";"Employees";"365";"DateLastUpdated";"3/21/18";"6/8/18")
//
// CUSTOM CHANGE DESC
// LogRecordEdit("Customer";"115485";"Employees";"365";"DateLastUpdated";"";"";"My custom changelog message.")


// SET UP VARIABLES

C_LONGINT:C283($0)

C_TEXT:C284($1; $vtLinkedTableName)
$vtLinkedTableName:=$1

C_TEXT:C284($2; $vtLinkedUniqueID)
$vtLinkedUniqueID:=$2

C_TEXT:C284($3; $vtAuthorTableName)
$vtAuthorTableName:=$3

C_TEXT:C284($4; $vtAuthorUniqueID)
$vtAuthorUniqueID:=$4

C_TEXT:C284($5; $vtFieldName)
$vtFieldName:=$5

C_TEXT:C284($6; $vtValueOriginal)
$vtValueOriginal:=$6

C_TEXT:C284($7; $vtValueChanged)
$vtValueChanged:=$7

C_TEXT:C284($vtCustomChangeDesc)
If (Count parameters:C259>7)
	C_TEXT:C284($8)
	$vtCustomChangeDesc:=$8
Else 
	$vtCustomChangeDesc:=""
End if 

C_TEXT:C284($vtKeyText)
If (Count parameters:C259>8)
	C_TEXT:C284($9)
	$vtKeyText:=$9
Else 
	$vtKeyText:=""
End if 

CREATE RECORD:C68([ChangeLog:149])

[ChangeLog:149]linkedTableName:2:=$vtLinkedTableName
[ChangeLog:149]ideLinked:3:=$vtLinkedUniqueID
[ChangeLog:149]authorTableName:9:=$vtAuthorTableName
[ChangeLog:149]nameIdAuthor:8:=$vtAuthorUniqueID
[ChangeLog:149]dtChange:6:=(Current date:C33-!1990-01-01!)*86400+Current time:C178
[ChangeLog:149]fieldName:10:=$vtFieldName
[ChangeLog:149]valueOriginal:4:=$vtValueOriginal
[ChangeLog:149]valueChanged:11:=$vtValueChanged
[ChangeLog:149]customChangeDesc:7:=$vtCustomChangeDesc
[ChangeLog:149]keyText:13:=$vtKeyText

SAVE RECORD:C53([ChangeLog:149])

$0:=[ChangeLog:149]idNum:1

UNLOAD RECORD:C212([ChangeLog:149])