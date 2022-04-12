//%attributes = {"publishedWeb":true}
//Procedure: PayPayInvoice
TRACE:C157
C_BOOLEAN:C305($0)
C_REAL:C285($1; $invNeed)

If (Count parameters:C259=0)
	$allowedDisc:=0
	$allowDiff:=True:C214
Else 
	$allowedDisc:=$1
	$allowDiff:=False:C215
	bCredit:=0
End if 
C_REAL:C285($Change; $ChangeInv; $ChangePay)
C_LONGINT:C283($i)
Case of 
	: (Locked:C147([Payment:28]))
		ALERT:C41("Payment "+String:C10([Payment:28]idNum:8)+" is locked and cannot be applied.")
	: (Record number:C243([Payment:28])<0)
		ALERT:C41("Payments record must be selected.")
	Else 
		Case of 
			: (Locked:C147([Invoice:26]))
				ALERT:C41("Invoice "+String:C10([Invoice:26]idNum:2)+" is locked and cannot be applied.")
			: (Record number:C243([Invoice:26])<0)
				ALERT:C41("Invoice record must be selected.")
			Else 
				If (Not:C34(([Payment:28]currency:22=[Invoice:26]currency:62) | (([Invoice:26]currency:62="") & ([Payment:28]currency:22=<>tcMONEYCHAR)) | (([Invoice:26]currency:62="") & ([Payment:28]currency:22=<>tcMONEYCHAR))))
					ALERT:C41("Invoice "+String:C10([Invoice:26]idNum:2)+" and payment "+String:C10([Payment:28]idNum:8)+" currency mismatch.")
				Else 
					$thePrec:=<>tcDecimalTt
					If (([Invoice:26]currency:62#<>tcMONEYCHAR) & ([Invoice:26]currency:62#""))
						QUERY:C277([Currency:61]; [Currency:61]currencyid:3=[Invoice:26]currency:62; *)
						QUERY:C277([Currency:61];  & [Currency:61]active:2=True:C214)
						$thePrec:=[Currency:61]convertPrec:7
					End if 
					TRACE:C157
					$invNeed:=[Invoice:26]balanceDue:44  //&$allowedDisc
					//what is this ?????
					Case of 
						: ((bCredit=1) & ([Payment:28]amountAvailable:19>$invNeed))
							$Change:=$invNeed
							If ($allowedDisc=0)
								[Invoice:26]balanceDue:44:=0
							End if 
							$ChangeInv:=[Invoice:26]balanceDue:44
							[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46+[Payment:28]amountAvailable:19; $thePrec)
							[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45+pDiff; $thePrec)
							[Payment:28]amountAvailable:19:=0
							[Invoice:26]balanceDue:44:=0
							
							
						: (bCredit=1)
							$Change:=[Payment:28]amountAvailable:19
							$ChangePay:=[Payment:28]amountAvailable:19
							$ChangeInv:=[Invoice:26]balanceDue:44
							[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46+[Payment:28]amountAvailable:19; $thePrec)
							[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45+pDiff; $thePrec)
							[Invoice:26]balanceDue:44:=0
							[Payment:28]amountAvailable:19:=0
							//: (($allowedDisc=0)&([Invoice]BalanceDue<=[Payments
							//]AmountAvailable))
							//$changeInv:=[Invoice]BalanceDue
							//$ChangePay:=[Invoice]BalanceDue
							//[Invoice]BalanceDue:=0
							//[Payment]AmountAvailable:=[Payment]AmountAvailable-$changeInv
							//: (($allowedDisc=0)&([Invoice]BalanceDue>[Payments
							//]AmountAvailable))
						Else 
							$Change:=pPayment
							[Payment:28]amountAvailable:19:=[Payment:28]amountAvailable:19-pPayment
							[Invoice:26]balanceDue:44:=[Invoice:26]balanceDue:44-pPayment
							[Invoice:26]appliedDiscount:45:=[Invoice:26]appliedDiscount:45+$allowedDisc
							[Invoice:26]appliedAmount:46:=[Invoice:26]appliedAmount:46+pPayment
							//: ([Invoice]BalanceDue<=[Payment]AmountAvailable)
							//[Invoice]AppliedDiscount:=[Invoice]AppliedDiscount
							//+$allowedDisc
							//$changeInv:=[Invoice]BalanceDue-$allowedDisc
							//$ChangePay:=$changeInv
							//[Invoice]BalanceDue:=0
							//[Payment]AmountAvailable:=[Payment]AmountAvailable-$changeInv
							//Else 
							//[Invoice]AppliedDiscount:=[Invoice]AppliedDiscount
							//+$allowedDisc
							//$changeInv:=[Payment]AmountAvailable
							//$ChangePay:=$changeInv
							//[Invoice]BalanceDue:=0
							//[Payment]AmountAvailable:=[Payment]AmountAvailable-$changeInv
					End case 
					//[Invoice]BalanceDue:=[Invoice]Total-[Invoice]AppliedDiscount-[Invoice]Applie
					[Payment:28]idNumInvoice:3:=[Invoice:26]idNum:2
					//[Payment]History:=[Payment]History+("\r"*Num([Payment]History#"
					//"))+"Invoice "+String([Invoice]InvoiceNum;"0000-0000")+"  ---  "+String(
					//-$Change;"000,000,000.00")
					//January 29, 1995
					If ($allowedDisc#0)
						TransAct_Create(1; $allowedDisc; "allowedDiscount")
					End if 
					If ($Change#0)
						TransAct_Create(1; -$Change)
					End if 
					If (($Change=0) & ($allowedDisc#0))
						ALERT:C41("Zero change in cash with Discount equal to "+String:C10($allowedDisc)+".")
					End if 
					[Payment:28]idNumOrder:2:=[Invoice:26]idNumOrder:1
					SAVE RECORD:C53([Payment:28])
					If ((bCredit=1) & (pDiff#0))
						PayAddCredit(pDiff; 1; [Invoice:26]idNumOrder:1; [Invoice:26]idNum:2; [Invoice:26]customerID:3)
					End if 
					Ledger_InvSave
					Ledger_PaySave
					
					PaidDaysCalc
					SAVE RECORD:C53([Customer:2])
					SAVE RECORD:C53([Invoice:26])
					
					pTotal:=[Invoice:26]balanceDue:44
					pPayment:=[Payment:28]amountAvailable:19
					pDiff:=pTotal-pPayment
					//
					doSearch:=0
					$0:=True:C214
					C_LONGINT:C283(eIvc2Pay; ePay2App)
					If (ePay2App#0)
						aPayments{aPayInvs}:=[Payment:28]amountAvailable:19  //Round(pPayment;<>tcDecimalTt)
						aPayInvs{aPayInvs}:=[Invoice:26]idNum:2
						aPayOrds{aPayInvs}:=[Invoice:26]idNumOrder:1
						$i:=aPayInvs
						////  CHOPPED  AL_GetScroll (ePay2App;viVert;viHorz)//Orders
						////  --  CHOPPED  AL_UpdateArrays (ePay2App;-2)
						//// -- AL_SetScroll (ePay2App;viVert;viHorz)
						//// -- AL_SetLine (ePay2App;$i)
					End if 
					If (eIvc2Pay#0)
						aUnPaid{aInvoices}:=Round:C94([Invoice:26]balanceDue:44; <>tcDecimalTt)
						aInvDisApp{aInvoices}:=Round:C94([Invoice:26]discountAccept:34; <>tcDecimalTt)
						$i:=aInvoices
						$k:=Size of array:C274(aInvSelRec)
						viLoR1:=0
						For ($i; 1; $k)
							viLoR1:=viLoR1+aUnPaid{aInvSelRec{$i}}
						End for 
						//AL_GetSelect (eIvc2Pay;aInvSelRec)
						////  CHOPPED  AL_GetScroll (eIvc2Pay;viVert;viHorz)
						////  --  CHOPPED  AL_UpdateArrays (eIvc2Pay;-2)
						//// -- AL_SetScroll (eIvc2Pay;viVert;viHorz)
						//// -- AL_SetSelect (eIvc2Pay;aInvSelRec)
					End if 
				End if 
		End case 
End case 