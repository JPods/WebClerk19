//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TaxSalesReport
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
If (count parmaters=0)
	$doReport:="Sales Tax"
Else 
	$doReport:=$1
End if 
Case of 
	: ($doReport="Sales Tax")
		vText2:="Sales Tax Report Period"
		jBetweenDates(vText2)
		If (OK=1)
			QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=vdDateBeg; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]dateInvoiced:35<=vdDateEnd)
			//SELECTION TO ARRAY([Invoice]InvoiceNum;aTmpLong1;[Invoice]TaxJuris;aTmp25Str1)
			RELATE MANY SELECTION:C340([InvoiceLine:54]invoiceNum:1)
			SELECTION TO ARRAY:C260([InvoiceLine:54]invoiceNum:1; aTmpLong1; [InvoiceLine:54]customerID:2; aTmp10Str1; [InvoiceLine:54]itemNum:4; aTmp35Str1; [InvoiceLine:54]extendedPrice:11; aTmpReal1; [InvoiceLine:54]taxJuris:14; aTmp20Str1; [InvoiceLine:54]salesTax:15; aTmpReal2)
			SORT ARRAY:C229(aTmpLong1; aTmp10Str1; aTmp35Str1; aTmpReal1; aTmpReal2; aTmp20Str1)
			vi2:=Size of array:C274(aTmpLong1)
			ARRAY TEXT:C222(aTmp25Str1; vi2)
			For (vi1; 1; vi2)
				If ([Invoice:26]invoiceNum:2#aTmpLong1{vi1})
					QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=aTmpLong1{vi1})
				End if 
				aTmp25Str1{vi1}:=[Invoice:26]taxJuris:33
			End for 
			//  
			vText1:="Period:  "+String:C10(vdDateBeg)+" to "+String:C10(vdDateEnd)
			MULTI SORT ARRAY:C718(aTmp25Str1; >; aTmp20Str1; >; aTmpLong1; >; aTmp10Str1; >; aTmp35Str1; >; aTmpReal1; aTmpReal2)
		End if 
	: ($doReport="Payment")
		vText2:="Payments in Period Report"
		jBetweenDates(vText2)
		If (OK=1)
			QUERY:C277([Payment:28]; [Payment:28]dateReceived:10>=vdDateBeg; *)
			QUERY:C277([Payment:28];  & [Payment:28]dateReceived:10<=vdDateEnd)
			SELECTION TO ARRAY:C260([Payment:28]idNum:8; aTmpLong1; [Payment:28]customerID:4; aTmp10Str1; [Payment:28]typePayment:6; aTmp20Str1; [Payment:28]amount:1; aTmpReal1; [Payment:28]dateReceived:10; aTmpDate1; [Payment:28]takeBy:42; aTmp25Str1)
			vi2:=Size of array:C274(aTmpLong1)
			ARRAY TEXT:C222(aTmp20Str2; vi2)
			For (vi1; 1; vi2)
				aTmp20Str2{vi1}:=Substring:C12(aTmp20Str1{vi1}; 1; 2)
			End for 
			//  
			vText1:="Period:  "+String:C10(vdDateBeg)+" to "+String:C10(vdDateEnd)
			MULTI SORT ARRAY:C718(aTmp20Str2; >; aTmp20Str1; >; aTmp10Str1; >; aTmpLong1; >; aTmpDate1; >; aTmpReal1; aTmp25Str1)
		End if 
End case 