//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/14/07, 18:48:14
// ----------------------------------------------------
// Method: OrderPostProduction
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($found)
$found:=Find in array:C230(<>aPrsName; "OrderProduction")  //("Processes")
If ($found>0)
	$processNum:=<>aPrsNum{$found}
	C_TEXT:C284(<>passFieldName; <>passTableName; <>passFindArrayName; <>passFindValue; <>passValueArrayName; <>passNewValue)
	
	<>passFieldName:=""
	<>passTableName:=""
	<>passFindArrayName:="aOpenOrders"
	<>passFindValue:=String:C10([Order:3]orderNum:2)
	<>passValueArrayName:="aOrdStatus"
	<>passNewValue:=[Order:3]status:59
	
	
	POST OUTSIDE CALL:C329($processNum)
End if 