//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/13/21, 18:51:35
// ----------------------------------------------------
// Method: STR_GetUniqueFieldPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tableName)
C_POINTER:C301($0; $ptField)
$tableName:=$1
Case of 
	: ($tableName="Customer")
		$0:=(->[Customer:2]customerID:1)
	: ($tableName="Vendor")
		$0:=(->[Vendor:38]vendorID:1)
	: ($tableName="Rep")
		$0:=(->[Rep:8]repID:1)
	: ($tableName="Item")
		$0:=(->[Item:4]itemNum:1)
	: ($tableName="Employee")
		$0:=(->[Employee:19]nameID:1)
		
		// numbers
	: ($tableName="Order")
		$0:=(->[Order:3]orderNum:2)
	: ($tableName="Proposal")
		$0:=(->[Proposal:42]proposalNum:5)
	: ($tableName="Invoice")
		$0:=(->[Order:3]orderNum:2)
	: ($tableName="PO")
		$0:=(->[PO:39]poNum:5)
	: ($tableName="Project")
		$0:=(->[Project:24]projectNum:1)
	: ($tableName="WorkOrder")
		$0:=(->[WorkOrder:66]woNum:29)
	Else 
		$ptField:=STR_GetFieldPointer($tableName; "idNum")
		$0:=$ptField
End case 

