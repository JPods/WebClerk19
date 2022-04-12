//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)
$0:=False:C215
If (aPayInvs=0)
	pPayment:=0
	viLoR2:=0
	If (aInvoices=0)
		pTotal:=0
	End if 
	pDiff:=Round:C94(pTotal-pPayment; <>tcDecimalTt)
Else 
	GOTO RECORD:C242([Payment:28]; aPayRecs{aPayInvs})
	viLoR2:=[Payment:28]amountAvailable:19
	
	vi6:=0
	If ((srAcct#[Payment:28]customerID:4) & (bpayAlt=0))
		aInvoices:=0
		If (b27=1)
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Payment:28]customerID:4)
		Else 
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Payment:28]customerID:4; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]balanceDue:44#0)
		End if 
		
		$0:=True:C214
		TRACE:C157
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
		srAcct:=[Customer:2]customerID:1
		srPhone:=[Customer:2]phone:13
		srZip:=[Customer:2]zip:8
		srCustomer:=[Customer:2]company:2
		srDivision:=String:C10(Cust_GetDivision)
		<>aLastRecNum{2}:=Record number:C243([Customer:2])
	Else 
		$0:=False:C215
	End if 
End if 
pTotal:=[Invoice:26]balanceDue:44
Case of 
	: ((([Payment:28]amountAvailable:19<0) & ([Invoice:26]balanceDue:44<0)) & ([Payment:28]amountAvailable:19>=[Invoice:26]balanceDue:44))
		pPayment:=[Payment:28]amountAvailable:19
	: ((([Payment:28]amountAvailable:19<0) & ([Invoice:26]balanceDue:44<0)) & ([Payment:28]amountAvailable:19<=[Invoice:26]balanceDue:44))
		pPayment:=[Invoice:26]balanceDue:44
	: ([Invoice:26]balanceDue:44<0)  //transfer to payment
		pPayment:=[Invoice:26]balanceDue:44
	: ([Payment:28]amountAvailable:19<0)  //transfer to invoice
		pPayment:=[Payment:28]amountAvailable:19
	: ([Payment:28]amountAvailable:19<=[Invoice:26]balanceDue:44)
		pPayment:=[Payment:28]amountAvailable:19
	: ([Payment:28]amountAvailable:19>=[Invoice:26]balanceDue:44)
		pPayment:=[Invoice:26]balanceDue:44
	Else 
		pPayment:=[Payment:28]amountAvailable:19
End case 
pDiff:=[Invoice:26]balanceDue:44-[Payment:28]amountAvailable:19