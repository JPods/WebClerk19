If (False:C215)
	//Object Method: oLoInvoices, b5
	//Date: 03/11/03
	//Who: Bill
	//Description: Added OverPay Invoices
End if 
//
C_LONGINT:C283($incInv; $incPay; $kInv; $kPay; $payAll)
KeyModifierCurrent
$payAll:=OptKey
CONFIRM:C162("Pay Invoices based on payments assigned to orders.")
If (OK=1)
	TRACE:C157
	FIRST RECORD:C50([Invoice:26])
	$kInv:=Records in selection:C76([Invoice:26])
	For ($incInv; 1; $kInv)
		LOAD RECORD:C52([Invoice:26])
		If (Locked:C147([Invoice:26]))
			BEEP:C151
		Else 
			If ([Invoice:26]balanceDue:44>0)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[Invoice:26]orderNum:1)
				If (Records in selection:C76([Order:3])=1)
					QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2; *)
					QUERY:C277([Payment:28];  & [Payment:28]AmountAvailable:19>0)
					If (Records in selection:C76([Payment:28])>=1)
						FIRST RECORD:C50([Payment:28])
						bCredit:=0
						ePay2App:=0
						eIvc2Pay:=0
						$kPay:=Records in selection:C76([Payment:28])
						For ($incPay; 1; $kPay)
							LOAD RECORD:C52([Payment:28])
							If (Locked:C147([Payment:28]))
								BEEP:C151
								BEEP:C151
							Else 
								If (<>vbOverPayInvoice)
									pPayment:=[Payment:28]AmountAvailable:19
									vi5:=Num:C11(PayPayInvoice)
								Else 
									If ([Invoice:26]balanceDue:44>0)
										If (([Payment:28]AmountAvailable:19>[Invoice:26]balanceDue:44) & ($payAll=0))
											pPayment:=[Invoice:26]balanceDue:44
										Else 
											pPayment:=[Payment:28]AmountAvailable:19
										End if 
										vi5:=Num:C11(PayPayInvoice)
									Else 
										$incPay:=$kPay
									End if 
								End if 
							End if 
							NEXT RECORD:C51([Payment:28])
						End for 
					End if 
				End if 
			End if 
		End if 
		NEXT RECORD:C51([Invoice:26])
	End for 
End if 