//%attributes = {"publishedSql":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/17/21, 17:39:12
// ----------------------------------------------------
// Method: STR_CounterNewSkip
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName; $vtFieldName)
C_LONGINT:C283($viIndex; $protectedFieldNum; $tableNum)
C_BOOLEAN:C305($vbooAutomaticUnique)
$tableName:=$1
$vbooAutomaticUnique:=False:C215
Case of 
	: ($tableName="Customer")
	: ($tableName="Vendor")
	: ($tableName="Rep")
	: ($tableName="Item")
	: ($tableName="Order")
	: ($tableName="Proposal")
	: ($tableName="Invoice")
	: ($tableName="PO")
	: ($tableName="Project")
	: ($tableName="WorkOrder")
	Else 
		$vbooAutomaticUnique:=True:C214
End case 
$0:=$vbooAutomaticUnique
