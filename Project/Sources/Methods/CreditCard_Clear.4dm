//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-10-06T00:00:00, 21:14:23
// ----------------------------------------------------
// Method: CreditCard_Clear
// Description
// Modified: 10/06/15
// Structure: CEv13_131005
// 
// Deletes all credit card data to prevent theft
// Parameters
// ----------------------------------------------------

ALL RECORDS:C47([QQQCustomer:2])
FIRST RECORD:C50([QQQCustomer:2])
vi2:=Records in selection:C76([QQQCustomer:2])
SET BLOB SIZE:C606(iLoBlob1; 0)
For (vi1; 1; vi2)
	[QQQCustomer:2]creditCardNum:53:=""
	[QQQCustomer:2]creditCardBlob:117:=iLoBlob1
	SAVE RECORD:C53([QQQCustomer:2])
	NEXT RECORD:C51([QQQCustomer:2])
End for 
UNLOAD RECORD:C212([QQQCustomer:2])


ALL RECORDS:C47([Payment:28])
FIRST RECORD:C50([Payment:28])
vi2:=Records in selection:C76([Payment:28])
SET BLOB SIZE:C606(iLoBlob1; 0)
For (vi1; 1; vi2)
	[Payment:28]CreditCardNum:13:=""
	[Payment:28]CreditCardBlob:53:=iLoBlob1
	SAVE RECORD:C53([Payment:28])
	NEXT RECORD:C51([Payment:28])
End for 
UNLOAD RECORD:C212([Payment:28])
