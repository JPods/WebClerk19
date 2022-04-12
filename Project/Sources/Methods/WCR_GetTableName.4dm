//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/17/19, 11:15:54
// ----------------------------------------------------
// Method: ResolveDataTypeName
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $tableName)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voResourceDefinition)

CREATE SET:C116([GenericChild2:91]; "TempSet_WCRGetTableName")

// ******************************************************************************************** //
// ** ATTEMPT TO GET THE RESOURCE OBJECT TO RESOLVE THE RESOURCE NAME TO TABLE NAME *********** //
// ******************************************************************************************** //

QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="WebClerkResource"; *)
QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]name:3=$vtResourceName; *)
QUERY:C277([GenericChild2:91])

If (Records in selection:C76([GenericChild2:91])>0)
	
	$tableName:=OB Get:C1224([GenericChild2:91]obGeneral:47; "tableName")
	
Else 
	
	$tableName:=$vtResourceName
	
End if 

// ******************************************************************************************** //
// ** RUN CLEANUP ***************************************************************************** //
// ******************************************************************************************** //

UNLOAD RECORD:C212([GenericChild2:91])
REDUCE SELECTION:C351([GenericChild2:91]; 0)
USE SET:C118("TempSet_WCRGetTableName")
CLEAR SET:C117("TempSet_WCRGetTableName")

// ******************************************************************************************** //
// ** RETURN THE TABLE NAME ******************************************************************* //
// ******************************************************************************************** //

$0:=$tableName