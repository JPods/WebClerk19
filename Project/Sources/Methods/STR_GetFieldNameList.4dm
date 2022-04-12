//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// ### bj ### 20200130_1343 got correct header
// Method: STR_GetFieldNameList
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $tableName; $vtFieldName)
$tableName:=$1
If (Count parameters:C259=0)
	$tableName:="Employee"
End if 
C_POINTER:C301($2; $vpatFieldNameList)
$vpatFieldNameList:=$2


ARRAY LONGINT:C221($arrTypes; 0)
ARRAY TEXT:C222($vpatFieldNameList->; 0)
C_OBJECT:C1216($obClass)
$obClass:=ds:C1482[$tableName]
If ($obClass#Null:C1517)
	ARRAY TEXT:C222($arrNames; 0)
	OB GET PROPERTY NAMES:C1232($obClass; $arrNames)
	SORT ARRAY:C229($arrNames)
	COPY ARRAY:C226($arrNames; $vpatFieldNameList->)
End if 


