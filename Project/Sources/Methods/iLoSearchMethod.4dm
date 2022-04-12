//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 11:31:50
// ----------------------------------------------------
// Method: srKeywordMethod
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------




// Generalize this
Case of 
	: (ptCurTable=(->[QQQCustomer:2]))
		WordCustomerInternal(srKeyword)
	: (ptCurTable=(->[QQQContact:13]))
		
	: (ptCurTable=(->[Order:3]))
		WordOrders
	: (ptCurTable=(->[QQQCustomer:2]))
		
	: (ptCurTable=(->[QQQCustomer:2]))
		
	Else 
		
End case 