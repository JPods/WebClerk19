//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/11/15, 16:53:30
// ----------------------------------------------------
// Method: TransactionStart
// Description
// 
//
// Parameters
// $1 pointer to primary table of transaction
// ----------------------------------------------------

C_POINTER:C301($1)


// ### jwm ### 20150911_1455 begin
// <>useTransactions:=True

If ((<>useTransactions) & (Not:C34(In transaction:C397)) & (Records in selection:C76($1->)#0) & (Not:C34(Locked:C147($1->))))
	//transactionActive:=True
	START TRANSACTION:C239
	SET QUERY AND LOCK:C661(True:C214)
	transactionActive:=In transaction:C397
	$0:=1
Else 
	$0:=0
End if 
// debug values remove later
$level:=Transaction level:C961
$InTransaction:=In transaction:C397
// TRACE
// ### jwm ### 20150911_1455 end

