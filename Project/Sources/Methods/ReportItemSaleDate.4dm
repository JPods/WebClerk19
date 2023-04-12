//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/16/20, 21:44:59
// ----------------------------------------------------
// Method: ReportItemSaleDate
// Description
// 
//
// Parameters
// ----------------------------------------------------



// QUERY([Item];[Item]QtyOnHand>0)

ALL RECORDS:C47([Item:4])
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	If ([Item:4]obGeneral:127=Null:C1517)
		[Item:4]obGeneral:127:=New object:C1471
	End if 
	If ([Item:4]obGeneral:127.history=Null:C1517)
		[Item:4]obGeneral:127.history:=New object:C1471
	End if 
	If ([Item:4]obGeneral:127.history.sales=Null:C1517)
		[Item:4]obGeneral:127.history.sales:=New object:C1471
	End if 
	QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Item:4]itemNum:1; *)
	QUERY:C277([DInventory:36];  & ; [DInventory:36]typeID:14="IV")
	If (Records in selection:C76([DInventory:36])=0)
		[Item:4]indicator7:101:=-1
		vDate1:=!00-00-00!
	Else 
		ORDER BY:C49([DInventory:36]; [DInventory:36]dtCreated:15; <)
		FIRST RECORD:C50([DInventory:36])
		DateTime_DTFrom([DInventory:36]dtCreated:15; ->vDate1)
		[Item:4]indicator7:101:=Current date:C33-vDate1
	End if 
	[Item:4]obGeneral:127.history.sales.dateLast:=vDate1
	[Item:4]obGeneral:127.history.sales.days:=[Item:4]indicator7:101
	[Item:4]obGeneral:127.history.sales.dateReport:=Current date:C33
	[Item:4]obGeneral:127.history.sales.qtyOnHand:=[Item:4]qtyOnHand:14
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 

If (False:C215)
	QUERY BY ATTRIBUTE:C1331([Item:4]; [Item:4]obGeneral:127; "history.sales.days"; #; -1)
End if 

