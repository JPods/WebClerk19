//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/12/08, 18:50:10
// ----------------------------------------------------
// Method: CC_Convert
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (<>tcCCStoragePolicy=2)
	QUERY:C277([QQQCustomer:2]; [QQQCustomer:2]creditCardNum:53#""; *)
	QUERY:C277([QQQCustomer:2];  & [QQQCustomer:2]creditCardNum:53#"x@")
	$cntRecs:=Records in selection:C76([QQQCustomer:2])
	FIRST RECORD:C50([QQQCustomer:2])
	For ($incRecs; 1; $cntRecs)
		$last4:=CC_ReturnXedOutCardNum([QQQCustomer:2]creditCardNum:53)
		[QQQCustomer:2]creditCardEncode:112:=CC_EncodeDecode(1; [QQQCustomer:2]creditCardNum:53; ->[QQQCustomer:2]creditCardBlob:117)
		[QQQCustomer:2]creditCardNum:53:=$last4
		SAVE RECORD:C53([QQQCustomer:2])
		NEXT RECORD:C51([QQQCustomer:2])
	End for 
	
	QUERY:C277([Payment:28]; [Payment:28]CreditCardNum:13#""; *)
	QUERY:C277([Payment:28];  & [Payment:28]CreditCardNum:13#"x@")
	$cntRecs:=Records in selection:C76([Payment:28])
	FIRST RECORD:C50([Payment:28])
	For ($incRecs; 1; $cntRecs)
		$last4:=CC_ReturnXedOutCardNum([Payment:28]CreditCardNum:13)
		[Payment:28]CreditCardEncode:50:=CC_EncodeDecode(1; [Payment:28]CreditCardNum:13; ->[Payment:28]CreditCardBlob:53)
		[Payment:28]CreditCardNum:13:=$last4
		SAVE RECORD:C53([Payment:28])
		NEXT RECORD:C51([Payment:28])
	End for 
End if 
