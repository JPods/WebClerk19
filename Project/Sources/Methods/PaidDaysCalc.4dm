//%attributes = {"publishedWeb":true}
//Procedure: PaidDaysCalc

If ([Invoice:26]balanceDue:44=0)
	[Invoice:26]datePaid:26:=Current date:C33
	[Invoice:26]daysPaid:27:=Invc_CalcDaysPd
	If ([Invoice:26]total:18>0)
		[QQQCustomer:2]daysPay:40:=[Invoice:26]daysPaid:27
	End if 
	//this is now handeled in Tally Receivables.
	//If ([Customer]InvoiceCount=0)
	//[Customer]DaysAvgPaid:=[Customer]DaysPay
	//Else 
	//[Customer]DaysAvgPaid:=([Invoice]DaysPaid+([Customer]DaysAvgPaid*(
	//[Customer]InvoiceCount-1)))/[Customer]InvoiceCount
	//End if 
End if 