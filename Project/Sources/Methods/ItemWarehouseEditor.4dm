//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/13/12, 18:02:47
// ----------------------------------------------------
// Method: ItemWarehouseEditor
// Description
// 
//
// Parameters
// ----------------------------------------------------


//Procedure: DB_SalesService
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Item Warehouse Editor")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("ItemWarehouse_WindowOpen"; <>tcPrsMemory; "Item Warehouse Editor")
End if 



