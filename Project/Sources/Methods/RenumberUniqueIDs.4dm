//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-09-16T00:00:00, 19:07:07
// ----------------------------------------------------
// Method: RenumberUniqueIDs
// Description
// Modified: 09/16/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283(vReplaceOrderNum; vReplaceInvoiceNum; vChangeOrderNum)

vChangeOrderNum:=0  // make this = 1 if OrderNum is to change


READ WRITE:C146([Order:3])
READ WRITE:C146([OrderLine:49])
READ WRITE:C146([Invoice:26])
READ WRITE:C146([InvoiceLine:54])
READ WRITE:C146([Payment:28])



Case of 
	: (vChangeOrderNum>1)
		vReplaceOrderNum:=vChangeOrderNum
	: (vChangeOrderNum=1)
		[Order:3]idNameAlt:86:=String:C10([Order:3]orderNum:2)
		vReplaceOrderNum:=CounterNew(->[Order:3])
	Else 
		vReplaceOrderNum:=[Order:3]orderNum:2
End case 
QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
FIRST RECORD:C50([OrderLine:49])
vi4:=Records in selection:C76([OrderLine:49])
For (vi3; 1; vi4)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]orderLineNum:48=[OrderLine:49]idNum:50)
	
	[OrderLine:49]orderNum:1:=vReplaceOrderNum
	vi6:=Records in selection:C76([InvoiceLine:54])
	FIRST RECORD:C50([InvoiceLine:54])
	For (vi5; 1; vi6)
		[InvoiceLine:54]orderNum:60:=vReplaceOrderNum
		[InvoiceLine:54]orderLineNum:48:=[OrderLine:49]idNum:50
		[InvoiceLine:54]dtLastSync:64:=111  // check Lines without this number
		
		SAVE RECORD:C53([InvoiceLine:54])
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	[OrderLine:49]dtLastSync:66:=111  // check Lines without this number
	SAVE RECORD:C53([OrderLine:49])
	NEXT RECORD:C51([OrderLine:49])
End for 


QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1=[Order:3]orderNum:2)
FIRST RECORD:C50([Invoice:26])
vi4:=Records in selection:C76([Invoice:26])
For (vi3; 1; vi4)
	
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
	vi6:=Records in selection:C76([InvoiceLine:54])
	
	QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
	vi8:=Records in selection:C76([Payment:28])
	
	[Invoice:26]orderNum:1:=vReplaceOrderNum
	[Invoice:26]dtLastSync:101:=111  // check Lines without this number
	[Invoice:26]invoiceNum:2:=CounterNew(->[Invoice:26])
	
	FIRST RECORD:C50([Payment:28])
	For (vi7; 1; vi8)
		[Payment:28]invoiceNum:3:=[Invoice:26]invoiceNum:2
		[Payment:28]orderNum:2:=vReplaceOrderNum
		[Payment:28]idNum:8:=CounterNew(->[Invoice:26])
		[Payment:28]dtCC:58:=111  // check Lines without this number
		SAVE RECORD:C53([Payment:28])
		NEXT RECORD:C51([Payment:28])
	End for 
	
	vi6:=Records in selection:C76([InvoiceLine:54])
	FIRST RECORD:C50([InvoiceLine:54])
	For (vi5; 1; vi6)
		[InvoiceLine:54]invoiceNum:1:=[Invoice:26]invoiceNum:2
		If ([InvoiceLine:54]dtLastSync:64#111)
			[InvoiceLine:54]dtLastSync:64:=111  // check Lines without this number
			
		End if 
		SAVE RECORD:C53([InvoiceLine:54])
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	SAVE RECORD:C53([Invoice:26])
	NEXT RECORD:C51([Invoice:26])
End for 
[Order:3]orderNum:2:=vReplaceOrderNum

SAVE RECORD:C53([Order:3])

UNLOAD RECORD:C212([Order:3])
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([OrderLine:49])
UNLOAD RECORD:C212([InvoiceLine:54])
UNLOAD RECORD:C212([Payment:28])


If (False:C215)
	
	READ WRITE:C146([Order:3])
	READ WRITE:C146([OrderLine:49])
	READ WRITE:C146([Invoice:26])
	READ WRITE:C146([InvoiceLine:54])
	READ WRITE:C146([Payment:28])
	
	QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1>9)
	vi2:=Records in selection:C76([Invoice:26])
	SELECTION TO ARRAY:C260([Invoice:26]; ALONGINT1)
	For (vi1; 1; vi2)
		GOTO RECORD:C242([Invoice:26]; aLongInt1{vi1})
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
		vi4:=Records in selection:C76([InvoiceLine:54])
		FIRST RECORD:C50([InvoiceLine:54])
		For (vi3; 1; vi4)
			If ([InvoiceLine:54]orderNum:60#[Invoice:26]orderNum:1)
				[InvoiceLine:54]orderNum:60:=[Invoice:26]orderNum:1
				[InvoiceLine:54]comment:40:=[InvoiceLine:54]comment:40+"\r"+"OrderNum added"
				SAVE RECORD:C53([InvoiceLine:54])
			End if 
			If ([InvoiceLine:54]orderLineNum:48=0)
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Invoice:26]orderNum:1; *)
				QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=[InvoiceLine:54]itemNum:4; *)
				QUERY:C277([OrderLine:49];  & [OrderLine:49]description:5=[InvoiceLine:54]description:5)
				If (Records in selection:C76([OrderLine:49])=1)
					[InvoiceLine:54]orderLineNum:48:=[OrderLine:49]idNum:50
					[InvoiceLine:54]comment:40:=[InvoiceLine:54]comment:40+"\r"+"OrderLineUniqueID added"
				Else 
					[InvoiceLine:54]orderLineNum:48:=-7
				End if 
				SAVE RECORD:C53([InvoiceLine:54])
			End if 
			NEXT RECORD:C51([InvoiceLine:54])
		End for 
	End for 
	
	
End if 






