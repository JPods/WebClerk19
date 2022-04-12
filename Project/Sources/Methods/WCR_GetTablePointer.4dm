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

C_POINTER:C301($0; $vpTable)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

// ******************************************************************************************** //
// ** ATTEMPT TO GET THE RESOURCE OBJECT TO RESOLVE THE RESOURCE NAME TO TABLE NAME *********** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	If (STR_IsTable($vtResourceName))
		
		$tableName:=$vtResourceName
		
	Else 
		
		CREATE SET:C116([GenericChild2:91]; "TempSet_WCRGetTablePointer")
		
		QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="WebClerkResource"; *)
		QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]name:3=$vtResourceName; *)
		QUERY:C277([GenericChild2:91])
		
		$tableName:=OB Get:C1224([GenericChild2:91]obGeneral:47; "tableName")
		
		UNLOAD RECORD:C212([GenericChild2:91])
		REDUCE SELECTION:C351([GenericChild2:91]; 0)
		USE SET:C118("TempSet_WCRGetTablePointer")
		CLEAR SET:C117("TempSet_WCRGetTablePointer")
		
	End if 
	
	$vpTable:=STR_GetTablePointer($tableName)
	
End if 

// ******************************************************************************************** //
// ** RETURN THE TABLE NAME ******************************************************************* //
// ******************************************************************************************** //

$0:=$vpTable
