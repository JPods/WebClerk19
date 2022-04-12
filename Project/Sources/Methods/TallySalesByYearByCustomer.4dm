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

READ ONLY:C145([Customer:2])
READ ONLY:C145([Invoice:26])
READ ONLY:C145([InvoiceLine:54])
READ ONLY:C145([Order:3])
READ ONLY:C145([OrderLine:49])
READ ONLY:C145([Service:6])

If (False:C215)  //testing only
	QUERY:C277([Customer:2]; [Customer:2]company:2="sara@"; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]company:2="Fleet@"; *)
	QUERY:C277([Customer:2])
End if 

vi2:=Records in selection:C76([Customer:2])
vi7:=Year of:C25(Current date:C33)
vtext9:=Request:C163("Process Yearly Sales for "+String:C10(vi2)+" Customers since which year?"; String:C10(vi7))
vi8:=Num:C11(vtext9)
If ((OK=1) & (vi8>1990) & (vi8<=vi7))
	CREATE EMPTY SET:C140([TallyResult:73]; "current")
	FIRST RECORD:C50([Customer:2])
	For (vi1; 1; vi2)
		For (vi3; 2012; 2013)
			vDate1:=Date:C102("01/01/"+String:C10(vi3))
			vDate2:=Date:C102("12/31/"+String:C10(vi3))
			
			QUERY:C277([TallyResult:73]; [TallyResult:73]customerID:30=[Customer:2]customerID:1; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="SalesByYear"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=String:C10(vi3)+"_SalesByYear")
			If (Records in selection:C76([TallyResult:73])=0)
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]customerID:30:=[Customer:2]customerID:1
				[TallyResult:73]purpose:2:="SalesByYear"
				[TallyResult:73]name:1:=String:C10(vi3)+"_SalesByYear"
				[TallyResult:73]itemNum:34:=[Customer:2]company:2
				[TallyResult:73]textBlk1:5:=[Customer:2]city:6+", "+[Customer:2]state:7+" "+[Customer:2]zip:8
				[TallyResult:73]nameLong1:24:="Sales for Year"
				[TallyResult:73]longint1:7:=vi3
				[TallyResult:73]nameReal1:20:="Invoice Amount"
				[TallyResult:73]nameReal2:21:="Invoice Margins"
				[TallyResult:73]nameReal3:22:="Invoice"
				[TallyResult:73]nameReal4:23:="Invoice Lines"
				[TallyResult:73]nameReal5:33:="Invoice Items"
				[TallyResult:73]nameReal6:37:="Order Amount"
				[TallyResult:73]nameReal7:38:="Order Margins"
				[TallyResult:73]nameReal8:39:="Order Cancel"
				[TallyResult:73]nameReal9:40:="Order"
				[TallyResult:73]nameReal10:41:="Order Lines"
				[TallyResult:73]nameReal11:49:="Order Items"
				[TallyResult:73]nameReal12:50:="Qty Cancel"
				[TallyResult:73]nameLong2:25:="Service Records"
			End if 
			
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]dateDocument:35>=vDate1; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]dateDocument:35<=vDate2)
			FIRST RECORD:C50([Invoice:26])
			
			
			vi4:=Records in selection:C76([Invoice:26])
			For (vi13; 1; vi14)
				GOTO SELECTED RECORD:C245([Invoice:26]; vi13)
				
			End for 
			UNLOAD RECORD:C212([Invoice:26])
			
			
			
			[TallyResult:73]real1:13:=Sum:C1([Invoice:26]amount:14)  //"Invoice Amount"
			[TallyResult:73]real2:14:=Sum:C1([Invoice:26]totalCost:37)  //"Invoice Margins"
			[TallyResult:73]real3:15:=Records in selection:C76([Invoice:26])  //"Invoice"
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]customerID:2=[Customer:2]customerID:1; *)
			QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]dateShipped:25>=vDate1; *)
			QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]dateShipped:25<=vDate2)
			[TallyResult:73]real4:16:=Records in selection:C76([InvoiceLine:54])  //"InvoiceLine"
			[TallyResult:73]real5:32:=Sum:C1([InvoiceLine:54]qty:7)  //"Invoice Items"
			
			QUERY:C277([Order:3]; [Order:3]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([Order:3];  & ; [Order:3]dateDocument:4>=vDate1; *)
			QUERY:C277([Order:3];  & ; [Order:3]dateDocument:4<=vDate2)
			
			[TallyResult:73]real6:42:=Sum:C1([Order:3]amount:24)  //"Order Amount"
			[TallyResult:73]real7:43:=Sum:C1([Order:3]totalCost:42)  //"Order Margins"
			[TallyResult:73]real8:44:=Sum:C1([Order:3]amountCancel:60)  //"Order Cancel"
			[TallyResult:73]real9:45:=Records in selection:C76([Order:3])  //"Invoice"  //"Orders Cancel"
			QUERY:C277([OrderLine:49]; [Order:3]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([OrderLine:49];  & ; [OrderLine:49]dateDocument:25>=vDate1; *)
			QUERY:C277([OrderLine:49];  & ; [OrderLine:49]dateDocument:25<=vDate2)
			
			[TallyResult:73]real10:46:=Records in selection:C76([OrderLine:49])  //"Order Lines"
			[TallyResult:73]real11:47:=Sum:C1([OrderLine:49]qty:6)  //"Order Items"
			[TallyResult:73]real12:48:=Sum:C1([OrderLine:49]qtyCancelled:51)
			
			vi7:=DateTime_Enter(vDate1; ?00:00:00?)
			vi8:=DateTime_Enter(vDate1; ?23:59:59?)
			
			QUERY:C277([Service:6]; [Service:6]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([Service:6];  & ; [Service:6]dtDocument:16>=vi7; *)
			QUERY:C277([Service:6];  & ; [Service:6]dtDocument:16<=vi8)
			[TallyResult:73]longInt2:8:=Records in selection:C76([OrderLine:49])  //"Service Records"
			
			SAVE RECORD:C53([TallyResult:73])
			ADD TO SET:C119([TallyResult:73]; "current")
		End for 
		NEXT RECORD:C51([Customer:2])
	End for 
	USE SET:C118("current")
	CLEAR SET:C117("current")
	DB_ShowCurrentSelection(->[TallyResult:73])
End if 
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