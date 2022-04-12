//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 11/04/19, 10:06:11
// ----------------------------------------------------
// Method: DB_SortCurSelectionBy
// Description
// 
//
// Usage:
//
// DB_SortCurSelectionBy ("products";"Profile1;>;ItemNum;>")  ===>   ORDER BY([Item];[Item]Profile1;>;[Item]ItemNum;>)
// 
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=$1

C_TEXT:C284($2; $vtFieldNamesAndOrders)
$vtFieldNamesAndOrders:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

ARRAY TEXT:C222($atFieldNamesAndOrders; 0)
C_TEXT:C284($vtBracketedTableName)
C_OBJECT:C1216($voResourceDefinition)
C_TEXT:C284($vtScriptToBeExecuted)
C_TEXT:C284($vtFieldName; $vtFieldOrder)
C_TEXT:C284($vtDiscardedOutput)

// ******************************************************************************************** //
// ** BUILD A POINTER TO THE RESOURCE'S TABLE, THEN UNLOAD RECORDS **************************** //
// ******************************************************************************************** //

If (WCR_IsResource($vtResourceName))
	
	// GET BRACKETED TABLE NAME
	
	$voResourceDefinition:=WCR_GetResourceDefinition($vtResourceName)
	$vtBracketedTableName:="["+OB Get:C1224($voResourceDefinition; "tableName")+"]"
	$vtScriptToBeExecuted:="ORDER BY("+$vtBracketedTableName
	
	// LOOP SPLIT THE FIELDNAMES AND ORDERS
	
	TextToArray($vtFieldNamesAndOrders; ->$atFieldNamesAndOrders; ";")
	
	If (Mod:C98(Size of array:C274($atFieldNamesAndOrders); 2)=1)
		APPEND TO ARRAY:C911($atFieldNamesAndOrders; "<")
	End if 
	
	For ($viCounter; 1; Size of array:C274($atFieldNamesAndOrders); 2)
		
		$vtFieldName:=$atFieldNamesAndOrders{$viCounter}
		$vtFieldOrder:=$atFieldNamesAndOrders{$viCounter+1}
		
		$vtScriptToBeExecuted:=$vtScriptToBeExecuted+";"+$vtBracketedTableName+$vtFieldName+";"+$vtFieldOrder
		
	End for 
	
	$vtScriptToBeExecuted:=$vtScriptToBeExecuted+")"
	
	// EXECUTE THE STRING
	
	$vtScriptToBeExecuted:="<!--#4DCODE\r"+$vtScriptToBeExecuted+"\r-->"
	PROCESS 4D TAGS:C816($vtScriptToBeExecuted; $vtDiscardedOutput)
	
End if 