//%attributes = {"publishedWeb":true}
// change to unlock
C_LONGINT:C283($i; $k)
C_REAL:C285($allowedDisc)
TRACE:C157
$k:=Size of array:C274(aInvSelRec)
$i:=0
If (Size of array:C274(aInvSelRec)>0)
	bCredit:=0  //no Diff on multiple pays
	Repeat 
		$i:=$i+1
		aInvoices:=aInvSelRec{$i}  //used in credit invoice, possibly others    
		GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvSelRec{$i}})
		LOAD RECORD:C52([Invoice:26])
		LOAD RECORD:C52([Payment:28])
		$allowedDisc:=aInvDiscountAmounts{$i}
		Case of 
			: ((Locked:C147([Invoice:26])) | (Locked:C147([Payment:28])))
				pPayment:=0
			: ((([Invoice:26]currency:62#"") & ([Invoice:26]currency:62#<>tcMONEYCHAR)) | (([Payment:28]currency:22#"") & ([Payment:28]currency:22#<>tcMONEYCHAR)))
				pPayment:=0
			: ([Invoice:26]balanceDue:44=0)
				pPayment:=0
			: ([Payment:28]amountAvailable:19>([Invoice:26]balanceDue:44+$allowedDisc))
				pPayment:=[Invoice:26]balanceDue:44-$allowedDisc
			Else 
				If ($allowedDisc=0)
					pPayment:=[Payment:28]amountAvailable:19
				Else 
					$allowedDisc:=Round:C94($allowedDisc*([Payment:28]amountAvailable:19/[Invoice:26]balanceDue:44); <>tcDecimalTt)
					pPayment:=[Payment:28]amountAvailable:19
				End if 
		End case 
		bCredit:=0
		If (pPayment#0)
			$ReCalc:=PayPayInvoice($allowedDisc)
		End if 
	Until (($i>=$k) | (pPayment=0))
End if 