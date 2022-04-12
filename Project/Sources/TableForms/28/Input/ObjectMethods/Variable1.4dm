If (False:C215)
	//Date: 06/18/02
	//Who: Janani, Arkware
	//Description: Modified to take off the beep and alert if a matching credit card 
	//is not found and point to default credit card entry
	VERSION_960
End if 

$savedResult:=CC_ReturnXedOutCardNum(Self:C308->)
$encryptResult:=CC_EncodeDecode(1; Self:C308->; ->[Payment:28]CreditCardBlob:53)  //save card encrypted
[Payment:28]CreditCardNum:13:=$savedResult
Self:C308->:=$savedResult
Format_CreditCd(Self:C308)
If (CCSelectCCType(Self:C308->; -><>aPayTypes))
	[Payment:28]TypePayment:6:=<>aPayTypes{<>aPayTypes}
End if 

