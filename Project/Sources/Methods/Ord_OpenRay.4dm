//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/12/18, 19:34:02
// ----------------------------------------------------
// Method: Ord_OpenRay
// Description
// 
//
// Parameters
// ----------------------------------------------------


QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6=!00-00-00!; *)
QUERY:C277([Order:3];  | [Order:3]dateInvoiceComp:6=!01-01-01!)
If (Records in selection:C76([Order:3])>50)
	REDUCE SELECTION:C351([Order:3]; 50)
End if 
SELECTION TO ARRAY:C260([Order:3]orderNum:2; <>aActiveWOs)
REDUCE SELECTION:C351([Order:3]; 0)
SORT ARRAY:C229(<>aActiveWOs)