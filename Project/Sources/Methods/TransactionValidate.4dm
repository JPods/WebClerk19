//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-12T00:00:00, 05:38:02
// ----------------------------------------------------
// Method: TransactionValidate
// Description
// Modified: 02/12/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// do not know if this is needed, 

// ### jwm ### 20150911_1455

C_BOOLEAN:C305($1; $validate)
If (In transaction:C397)  // ### jwm ### 20150911_1703 if inside a transaction
	$validate:=True:C214
	If (Count parameters:C259=1)
		$validate:=$1
	End if 
	Case of 
		: (<>useTransactions)
			If ($validate)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
		: (transactionActive)
			VALIDATE TRANSACTION:C240
	End case 
	SET QUERY AND LOCK:C661(False:C215)
	transactionActive:=In transaction:C397
End if 
