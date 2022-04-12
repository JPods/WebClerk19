//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/15/09, 11:52:40
// ----------------------------------------------------
// Method: CC_SaveData
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0; $savedResult)  //data in, data out
Case of 
	: (<>tcCCStoragePolicy=1)  //save just the last 4
		ALERT:C41("Default set to save only last 4")
		$savedResult:=CC_ReturnXedOutCardNum($1)
		[QQQCustomer:2]creditCardEncode:112:=""
		SET BLOB SIZE:C606([QQQCustomer:2]creditCardBlob:117; 0)
	: (<>tcCCStoragePolicy=2)
		$savedResult:=CC_ReturnXedOutCardNum($1)  //save last 4
		[QQQCustomer:2]creditCardEncode:112:=""  //do not save anything in this field
		$encryptResult:=CC_EncodeDecode(1; $1; ->[QQQCustomer:2]creditCardBlob:117)  //save card encrypted
	: (<>tcCCStoragePolicy=3)
		$savedResult:=$1
		[QQQCustomer:2]creditCardEncode:112:=$1  //save the card value in the clear
		$encryptResult:=CC_EncodeDecode(1; $1; ->[QQQCustomer:2]creditCardBlob:117)  //save the card value encrypted
End case 
$0:=$savedResult

//[Payment]CreditCardBlob

