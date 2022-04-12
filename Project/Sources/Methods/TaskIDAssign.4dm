//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/28/06, 05:34:26
// ----------------------------------------------------
// Method: taskIDAssign
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
If ($1->=0)
	C_OBJECT:C1216($obRec)
	$obRec:=ds:C1482.Task.new()
	$obRec.obRelate:=New object:C1471
	If (Count parameters:C259>1)
		$obRec.state:="Assign-variable"
	Else 
		C_TEXT:C284($tableName)
		$tableName:=Table name:C256($1)
		$obRec.state:="Assign-"+$tableName
		Case of 
			: ($tableName="Customer")
				$obRec.obRelate[$tableName]:=[Customer:2]customerID:1
			: ($tableName="Proposal")
				$obRec.obRelate[$tableName]:=[Proposal:42]proposalNum:5
			: ($tableName="Order")
				$obRec.obRelate[$tableName]:=[Order:3]orderNum:2
			: ($tableName="Invoice")
				$obRec.obRelate[$tableName]:=[Invoice:26]invoiceNum:2
			: ($tableName="Payment")
				$obRec.obRelate[$tableName]:=[Payment:28]idNum:8
			: ($tableName="Service")
				$obRec.obRelate[$tableName]:=[Service:6]idNum:26
		End case 
	End if 
	$result_o:=$obRec.save()
	$1->:=$obRec.idNum
End if 