//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/13/21, 17:55:29
// ----------------------------------------------------
// Method: STR_IsField
// Description
// 
//
// Parameters
// ----------------------------------------------------

TRACE:C157
// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //
C_BOOLEAN:C305($0; $vbIsField)
$vbIsField:=False:C215

C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $vtFieldName)
C_OBJECT:C1216($obClass; $obSel; $obField)

$tableName:=$1
$vtFieldName:=$2

$obSel:=ds:C1482[$tableName].new()
If ($obSel#Null:C1517)
	$obField:=$obSel.getDataClass()[$vtFieldName]
	If ($obField#Null:C1517)
		$vbIsField:=False:C215
	End if 
End if 


// ******************************************************************************************** //
// ** RETURN THE OBJECT, EITHER WITH THE TABLE DEFINITION, OR AN ERROR MESSAGE **************** //
// ******************************************************************************************** //

$0:=$vbIsField