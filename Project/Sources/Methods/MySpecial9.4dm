//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-01T00:00:00, 19:18:19
// ----------------------------------------------------
// Method: MySpecial9
// Description
// Modified: 01/01/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

ALL RECORDS:C47([OrderLine:49])
vi2:=Records in selection:C76([OrderLine:49])
For (vi1; 1; vi2)
	GOTO SELECTED RECORD:C245([OrderLine:49]; vi1)
	Case of 
		: ([OrderLine:49]typeSale:28="i@")
			[OrderLine:49]typeSale:28:="B-In-Stock"
		: ([OrderLine:49]typeSale:28="o@")
			[OrderLine:49]typeSale:28:="C-Order"
		: ([OrderLine:49]typeSale:28="s@")
			[OrderLine:49]typeSale:28:="D-Sale"
		: ([OrderLine:49]typeSale:28="m@")
			[OrderLine:49]typeSale:28:="A-MSRP"
		Else 
			// leave as is
	End case 
	SAVE RECORD:C53([OrderLine:49])
End for 
UNLOAD RECORD:C212([OrderLine:49])




ALL RECORDS:C47([Order:3])
vi2:=Records in selection:C76([Order:3])
For (vi1; 1; vi2)
	GOTO SELECTED RECORD:C245([Order:3]; vi1)
	Case of 
		: ([Order:3]typeSale:22="i@")
			[Order:3]typeSale:22:="B-In-Stock"
		: ([Order:3]typeSale:22="o@")
			[Order:3]typeSale:22:="C-Order"
		: ([Order:3]typeSale:22="s@")
			[Order:3]typeSale:22:="D-Sale"
		: ([Order:3]typeSale:22="m@")
			[Order:3]typeSale:22:="A-MSRP"
		Else 
			// leave as is
	End case 
	SAVE RECORD:C53([Order:3])
End for 
UNLOAD RECORD:C212([Order:3])

ALL RECORDS:C47([InvoiceLine:54])
vi2:=Records in selection:C76([OrderLine:49])
For (vi1; 1; vi2)
	GOTO SELECTED RECORD:C245([InvoiceLine:54]; vi1)
	Case of 
		: ([InvoiceLine:54]typeSale:27="i@")
			[InvoiceLine:54]typeSale:27:="B-In-Stock"
		: ([InvoiceLine:54]typeSale:27="o@")
			[InvoiceLine:54]typeSale:27:="C-Order"
		: ([InvoiceLine:54]typeSale:27="s@")
			[InvoiceLine:54]typeSale:27:="D-Sale"
		: ([InvoiceLine:54]typeSale:27="m@")
			[InvoiceLine:54]typeSale:27:="A-MSRP"
		Else 
			// leave as is
	End case 
	SAVE RECORD:C53([InvoiceLine:54])
End for 
UNLOAD RECORD:C212([InvoiceLine:54])


ALL RECORDS:C47([Invoice:26])
vi2:=Records in selection:C76([Invoice:26])
For (vi1; 1; vi2)
	GOTO SELECTED RECORD:C245([Invoice:26]; vi1)
	Case of 
		: ([Invoice:26]typeSale:49="i@")
			[Invoice:26]typeSale:49:="B-In-Stock"
		: ([Invoice:26]typeSale:49="o@")
			[Invoice:26]typeSale:49:="C-Order"
		: ([Invoice:26]typeSale:49="s@")
			[Invoice:26]typeSale:49:="D-Sale"
		: ([Invoice:26]typeSale:49="m@")
			[Invoice:26]typeSale:49:="A-MSRP"
		Else 
			// leave as is
	End case 
	SAVE RECORD:C53([Invoice:26])
End for 
UNLOAD RECORD:C212([Invoice:26])



ALL RECORDS:C47([QQQCustomer:2])
vi2:=Records in selection:C76([QQQCustomer:2])
For (vi1; 1; vi2)
	GOTO SELECTED RECORD:C245([QQQCustomer:2]; vi1)
	Case of 
		: ([QQQCustomer:2]typeSale:18="o@")
			[QQQCustomer:2]typeSale:18:="C-Order"
		: ([QQQCustomer:2]typeSale:18="s@")
			[QQQCustomer:2]typeSale:18:="D-Sale"
		: ([QQQCustomer:2]typeSale:18="m@")
			[QQQCustomer:2]typeSale:18:="A-MSRP"
		Else 
			//  : ([Customer]TypeSale="i@")
			[QQQCustomer:2]typeSale:18:="B-In-Stock"
			// leave as is
	End case 
	SAVE RECORD:C53([QQQCustomer:2])
End for 
UNLOAD RECORD:C212([QQQCustomer:2])


