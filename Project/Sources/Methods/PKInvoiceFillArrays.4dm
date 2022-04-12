//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKInvoiceFillArrays
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

C_LONGINT:C283($1; $2; $3; $4; $incRay; $sizeRay; $diff; $p; $w; $k; $i)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aInvoices; 0)
		ARRAY DATE:C224(aInvDate; 0)
		ARRAY TEXT:C222(aCustPO; 0)
		ARRAY LONGINT:C221(aOrders; 0)
		ARRAY TEXT:C222(aInvCust; 0)
		ARRAY LONGINT:C221(aInvRecs; 0)
		//
		ARRAY LONGINT:C221(aInvoiceRecSel; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([Invoice:26]idNum:2; aInvoices; <>ptInvoiceDateFld->; aInvDate; [Invoice:26]customerPO:29; aCustPO; [Invoice:26]idNumOrder:1; aOrders; [Invoice:26]customerID:3; aInvCust; [Invoice:26]; aInvRecs)
		ARRAY LONGINT:C221(aInvoiceRecSel; 0)
		UNLOAD RECORD:C212([Invoice:26])
End case 
//  
If ($4>0)
	//  --  CHOPPED  AL_UpdateArrays($4; -2)  //Size of array(aInvoices))
End if 