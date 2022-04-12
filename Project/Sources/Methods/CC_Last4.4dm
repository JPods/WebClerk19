//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/15/12, 19:09:28
// ----------------------------------------------------
// Method: CC_Last4
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
C_BOOLEAN:C305($1; $moreMessage)
If (Count parameters:C259=0)
	$moreMessage:=True:C214
Else 
	$moreMessage:=$1
End if 
QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
If (Records in selection:C76([Payment:28])=0)
	If ($moreMessage)
		$0:="No Payment specifically attached to Invoice"
	Else 
		$0:=""
	End if 
Else 
	If ((Records in selection:C76([Payment:28])=1) | ($moreMessage))
		FIRST RECORD:C50([Payment:28])
		$w:=Find in array:C230(<>aPayTypes; [Payment:28]TypePayment:6)
		If (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd)
			$0:=[Payment:28]TypePayment:6+"; "+[Payment:28]CreditCardNum:13
		Else 
			$0:=[Payment:28]TypePayment:6+"; "+"[Payment]CheckNum"
		End if 
	Else 
		$0:="Multiple Payments"
	End if 
End if 