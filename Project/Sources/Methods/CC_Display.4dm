//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/14/08, 11:45:53
// ----------------------------------------------------
// Method: CC_Display
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("CreditCardView"))
	
	C_TEXT:C284($theCreditCard)
	$theCreditCard:=""
	Case of 
		: (ptCurTable=(->[Payment:28]))
			$theCreditCard:=CC_EncodeDecode(0; ""; ->[Payment:28]CreditCardBlob:53)
			If (vHere>1)
				pCreditCardLast4:=$theCreditCard
			End if 
		: (ptCurTable=(->[QQQCustomer:2]))
			$theCreditCard:=CC_EncodeDecode(0; ""; ->[QQQCustomer:2]creditCardBlob:117)
			If (vHere>1)
				pCreditCardLast4:=$theCreditCard
			End if 
	End case 
	If (vHere<2)
		If ($theCreditCard#"")
			//Format_CreditCd (->iLoText1)
			ALERT:C41($theCreditCard)
		End if 
	End if 
	$theCreditCard:=""
	
End if 