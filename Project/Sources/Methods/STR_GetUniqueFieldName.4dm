//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/10/21, 23:00:06
// ----------------------------------------------------
// Method: STR_GetUniqueFieldName
// Description
// 
//
// Parameters
// ----------------------------------------------------



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_TEXT:C284($0; $vtUniqueFieldName)

C_TEXT:C284($1; $tableName)
C_OBJECT:C1216($obDateStore; $obDataClass)
C_LONGINT:C283($viTableNum)
$tableName:=$1
Case of 
	: ($tableName="Customer")
		$vtUniqueFieldName:="customerID"
	: ($tableName="Employee")
		$vtUniqueFieldName:="nameID"
	: ($tableName="Item")
		$vtUniqueFieldName:="itemNum"
	: ($tableName="Rep")
		$vtUniqueFieldName:="repId"
	: ($tableName="Vendor")
		$vtUniqueFieldName:="vendorId"
		
	: ($tableName="Invoice")
		$vtUniqueFieldName:="invoiceNum"
	: ($tableName="Order")
		$vtUniqueFieldName:="orderNum"
	: ($tableName="PO")
		$vtUniqueFieldName:="poNum"
	: ($tableName="Project")
		$vtUniqueFieldName:="projectNum"
	: ($tableName="Proposal")
		$vtUniqueFieldName:="proposalNum"
	: ($tableName="WorkOrder")
		$vtUniqueFieldName:="woNum"
	Else 
		$vtUniqueFieldName:="idNum"
End case 

$0:=$vtUniqueFieldName

