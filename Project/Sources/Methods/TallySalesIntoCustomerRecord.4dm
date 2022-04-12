//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-02T00:00:00, 09:50:58
// ----------------------------------------------------
// Method: TallySalesByYearByCustomer
// Description
// Modified: 08/02/13
// 
// 
//
// Parameters
// ----------------------------------------------------

vi2:=Records in selection:C76([Customer:2])
FIRST RECORD:C50([Customer:2])
For (vi1; 1; vi2)
	vDate1:=!2012-01-01!
	vDate2:=!2012-12-31!
	QUERY:C277([Order:3]; [Order:3]customerID:1=[Customer:2]customerID:1; *)
	QUERY:C277([Order:3];  & ; [Order:3]dateOrdered:4>=vDate1; *)
	QUERY:C277([Order:3];  & ; [Order:3]dateOrdered:4<=vDate2)
	[Customer:2]salesLastYr:48:=Sum:C1([Order:3]amount:24)
	vDate1:=!2013-01-01!
	vDate2:=!2013-12-31!
	QUERY:C277([Order:3]; [Order:3]customerID:1=[Customer:2]customerID:1; *)
	QUERY:C277([Order:3];  & ; [Order:3]dateOrdered:4>=vDate1; *)
	QUERY:C277([Order:3];  & ; [Order:3]dateOrdered:4<=vDate2)
	[Customer:2]salesYTD:47:=Sum:C1([Order:3]amount:24)
	
	
	
	SAVE RECORD:C53([Customer:2])
	NEXT RECORD:C51([Customer:2])
End for 

USE SET:C118("current")
CLEAR SET:C117("current")
DB_ShowCurrentSelection(->[TallyResult:73])

REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([Invoice:26]; 0)
REDUCE SELECTION:C351([InvoiceLine:54]; 0)
REDUCE SELECTION:C351([Order:3]; 0)
REDUCE SELECTION:C351([OrderLine:49]; 0)
REDUCE SELECTION:C351([Service:6]; 0)
READ WRITE:C146([Customer:2])
READ WRITE:C146([Invoice:26])
READ WRITE:C146([InvoiceLine:54])
READ WRITE:C146([Order:3])
READ WRITE:C146([OrderLine:49])
READ WRITE:C146([Service:6])