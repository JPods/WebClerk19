//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $w)
C_POINTER:C301($2; $3; $4)
If ($1=1)
	jPopUpArray($3; $2)  //(Self;[Order]Currency)
Else 
	// zzzqqq PopUpWildCard($2; $3; $5)  //([Order]Currency;<>aExchID;[Currency])
End if   //$4 is rate
$w:=Find in array:C230(<>aExchID; $2->)
If ($w>0)
	QUERY:C277([QQQCurrency:61]; [QQQCurrency:61]CurrencyID:3=$2->)
	If (Records in selection:C76([QQQCurrency:61])=1)
		$4->:=[QQQCurrency:61]ExchangeRate:4
		viExConPrec:=[QQQCurrency:61]ConvertPrec:7
		viExDisPrec:=[QQQCurrency:61]DisplayPrec:6
	Else 
		ALERT:C41("There is not a unique, active currency record.")
		$2->:=""
	End if 
	UNLOAD RECORD:C212([QQQCurrency:61])
Else 
	$2->:=""
End if 
