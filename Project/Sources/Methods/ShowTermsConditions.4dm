//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/29/20, 19:07:43
// ----------------------------------------------------
// Method: ShowTermsConditions
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable; $ptField)
$ptField:=$1
$ptTable:=Table:C252(Table:C252($ptField))
C_TEXT:C284($tableName)
$tableName:=Table name:C256($ptTable)
C_LONGINT:C283($viDocID)

Case of 
	: ($tableName="Order")
		$viDocID:=[Order:3]orderNum:2
	: ($tableName="PO")
		$viDocID:=[PO:39]poNum:5
	: ($tableName="Invoice")
		$viDocID:=[Invoice:26]invoiceNum:2
	: ($tableName="Proposal")
		$viDocID:=[Proposal:42]proposalNum:5
End case 

READ ONLY:C145([ContractTerm:156])
If ($ptField->="")
	ALL RECORDS:C47([ContractTerm:156])
	ProcessTableOpen(Table:C252(->[ContractTerm:156]); ""; $tableName+": "+String:C10($viDocID))
Else 
	QUERY:C277([ContractTerm:156]; [ContractTerm:156]name:5=$ptField->)
	If (Records in selection:C76([ContractTerm:156])=0)
		ALL RECORDS:C47([ContractTerm:156])
	End if 
	ProcessTableOpen(Table:C252(->[ContractTerm:156]); ""; $tableName+": "+String:C10($viDocID))
End if 
READ WRITE:C146([ContractTerm:156])
REDUCE SELECTION:C351([ContractTerm:156]; 0)