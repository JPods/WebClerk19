//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-16T00:00:00, 15:42:46
// ----------------------------------------------------
// Method: WebItemAddwithDescription
// Description
// Modified: 08/16/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// ### bj ### 20200427_0010
// not used that I can see

// WCCScriptstest
iloText4:="/"
If (variable3#"")
	QUERY:C277([Item:4]; [Item:4]itemNum:1=variable3)
	Case of 
		: (variable1="Order")
			CREATE RECORD:C68([OrderLine:49])
			
			[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
			[OrderLine:49]seq:30:=[OrderLine:49]idNum:50
			[OrderLine:49]orderNum:1:=Num:C11(variable2)
			[OrderLine:49]itemNum:4:=[Item:4]itemNum:1
			vi7:=Position:C15(iloText4; variable4)
			If ((variable3="discount") & (vi7>0))
				vi6:=vi7-1
				vR1:=Num:C11(Substring:C12(variable4; 1; vi6))
				vi6:=vi7+1
				vR2:=Num:C11(Substring:C12(variable4; vi6))
				[OrderLine:49]description:5:=variable3+": On "+String:C10(vR1; "$###,##0")+" of "+String:C10(vR2; "#0.0")+"%"
				[OrderLine:49]qtyOrdered:6:=1
				[OrderLine:49]unitPrice:9:=-Round:C94(vR1*vR2*0.01; 2)
			Else 
				[OrderLine:49]description:5:=variable3+": "+variable4
			End if 
			ParseOrderLines
		: (variable1="Invoice")
			QUERY:C277([Item:4]; [Item:4]itemNum:1=variable3)
			CREATE RECORD:C68([InvoiceLine:54])
			
			[InvoiceLine:54]lineNum:3:=[InvoiceLine:54]idNum:47
			[InvoiceLine:54]seq:28:=[InvoiceLine:54]idNum:47
			[InvoiceLine:54]invoiceNum:1:=Num:C11(variable2)
			[InvoiceLine:54]itemNum:4:=variable3
			vi7:=Position:C15(iloText4; variable4)
			If ((variable3="discount") & (vi7>0))
				vi6:=vi7-1
				vR1:=Num:C11(Substring:C12(variable4; 1; vi6))
				vi6:=vi7+1
				vR2:=Num:C11(Substring:C12(variable4; vi6))
				[InvoiceLine:54]description:5:=variable3+": On "+String:C10(vR1; "$###,##0")+" of "+String:C10(vR2; "#0.0")+"%"
				[InvoiceLine:54]qtyShipped:7:=1
				[InvoiceLine:54]unitPrice:9:=-Round:C94(vR1*vR2*0.01; 2)
			Else 
				[InvoiceLine:54]description:5:=variable3+": "+variable4
			End if 
			ParseInvoiceLines
	End case 
End if 