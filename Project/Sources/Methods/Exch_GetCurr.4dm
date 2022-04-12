//%attributes = {"publishedWeb":true}
//Procedure: Exch_GetCurr
C_TEXT:C284($1)  //currency ID
C_LONGINT:C283($0)  //0 if error, 1 if oK
C_REAL:C285(vrExRate)
C_POINTER:C301($2)  //rate
If ((<>tcMONEYCHAR=$1) | ($1="") | (<>tcMONEYCHAR=""))
	$0:=0  //skip  
	viExConPrec:=-1000
	viExDisPrec:=-1000
	vrExRate:=1
Else 
	QUERY:C277([QQQCurrency:61]; [QQQCurrency:61]CurrencyID:3=$1; *)
	QUERY:C277([QQQCurrency:61];  & [QQQCurrency:61]Active:2=True:C214)
	If (Records in selection:C76([QQQCurrency:61])#1)
		ALERT:C41("No unique/active currency record found.")
		If (Records in selection:C76([QQQCurrency:61])=0)
			viExConPrec:=<>tcDecimalTt
			viExDisPrec:=<>tcDecimalTt
			vrExRate:=1
		Else 
			FIRST RECORD:C50([QQQCurrency:61])
			viExConPrec:=[QQQCurrency:61]ConvertPrec:7
			viExDisPrec:=[QQQCurrency:61]DisplayPrec:6
			vrExRate:=[QQQCurrency:61]ExchangeRate:4
			UNLOAD RECORD:C212([QQQCurrency:61])
		End if 
		$0:=1  //do
	Else 
		C_LONGINT:C283(viExConPrec; viExDisPrec)
		If (([QQQCurrency:61]ExchangeRate:4=0) | ([QQQCurrency:61]ExchangeRate:4=1))
			$0:=0  //skip
			viExConPrec:=[QQQCurrency:61]ConvertPrec:7
			viExDisPrec:=[QQQCurrency:61]DisplayPrec:6
			vrExRate:=1
		Else 
			viExConPrec:=[QQQCurrency:61]ConvertPrec:7
			viExDisPrec:=[QQQCurrency:61]DisplayPrec:6
			vrExRate:=[QQQCurrency:61]ExchangeRate:4
			$0:=1  //do
		End if 
		UNLOAD RECORD:C212([QQQCurrency:61])
	End if 
End if 