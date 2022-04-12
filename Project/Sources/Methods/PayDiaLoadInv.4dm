//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-21T00:00:00, 15:23:17
// ----------------------------------------------------
// Method: PayDiaLoadInv
// Description
// Modified: 08/21/17
// 
// 
//
// Parameters
// ----------------------------------------------------



C_BOOLEAN:C305($0)
C_POINTER:C301($ptSt)
C_LONGINT:C283($i)
If (aInvoices=0)
	For ($i; 1; 4)
		$ptStr:=Get pointer:C304("v"+String:C10($i))
		$ptStr->:=""
	End for 
Else 
	GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvoices})
	LOAD RECORD:C52([Invoice:26])
	If (Locked:C147([Invoice:26]))
		jAlertMessage(10011)
	End if 
	If ([Invoice:26]customerID:3#srAcct)
		aPayInvs:=0
		If (bpayAlt=0)
			If (b27=1)
				QUERY:C277([Payment:28]; [Payment:28]customerID:4=[Invoice:26]customerID:3)
			Else 
				QUERY:C277([Payment:28]; [Payment:28]customerID:4=[Invoice:26]customerID:3; *)
				QUERY:C277([Payment:28];  & [Payment:28]amountAvailable:19#0)
			End if 
			
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
		If (srAcct#[Invoice:26]customerID:3)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			srAcct:=[Customer:2]customerID:1
			srPhone:=[Customer:2]phone:13
			srZip:=[Customer:2]zip:8
			srCustomer:=[Customer:2]company:2
			srDivision:=String:C10(Cust_GetDivision)
			<>aLastRecNum{2}:=Record number:C243([Customer:2])
		End if 
	End if 
	For ($i; 1; 4)
		$ptStr:=Get pointer:C304("v"+String:C10($i))
		$ptStr->:=""
	End for 
	Case of 
		: (aInvDays{aInvoices}<31)  //current
			v1:="x"
		: (aInvDays{aInvoices}<61)  //30 to 60
			v2:="x"
		: (aInvDays{aInvoices}<91)  //60 to 90
			v3:="x"
		Else   //            over 90
			v4:="x"
	End case 
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