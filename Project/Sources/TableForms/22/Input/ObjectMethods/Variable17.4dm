If (<>aExchID>1)
	READ ONLY:C145([QQQCurrency:61])
	QUERY:C277([QQQCurrency:61]; [QQQCurrency:61]CurrencyID:3=<>aExchID{<>aExchID}; *)
	QUERY:C277([QQQCurrency:61];  & [QQQCurrency:61]Active:2=True:C214)
	[ItemXRef:22]Currency:16:=<>aExchID{<>aExchID}
	If (Records in selection:C76([QQQCurrency:61])=1)
		viloR1:=Round:C94([ItemXRef:22]Cost:7*[QQQCurrency:61]ExchangeRate:4; [QQQCurrency:61]DisplayPrec:6)
	End if 
	UNLOAD RECORD:C212([QQQCurrency:61])
	READ WRITE:C146([QQQCurrency:61])
End if 