C_LONGINT:C283($selected)
$selected:=<>aExchID
jPopUpArray(Self:C308; ->vStr20Lo1)  //(Self;[Order]Currency)
If ($selected>1)
	<>aExchID:=$selected
	strCurrency:=<>aExchID{<>aExchID}
	QUERY:C277([QQQCurrency:61]; [QQQCurrency:61]CurrencyID:3=strCurrency)
	If (Records in selection:C76([QQQCurrency:61])=1)
		vRLo1:=[QQQCurrency:61]ExchangeRate:4
		viExConPrec:=[QQQCurrency:61]ConvertPrec:7
		viExDisPrec:=[QQQCurrency:61]DisplayPrec:6
	Else 
		ALERT:C41("There is not a unique, active currency record.")
		vRLo1:=1
	End if 
	UNLOAD RECORD:C212([QQQCurrency:61])
	vR7:=Round:C94([Item:4]priceA:2*vRLo1; viExDisPrec)
	vR8:=Round:C94([Item:4]priceB:3*vRLo1; viExConPrec)
	vR9:=Round:C94([Item:4]priceC:4*vRLo1; viExConPrec)
	vR10:=Round:C94([Item:4]priceD:5*vRLo1; viExConPrec)
	vR11:=Round:C94([Item:4]costLastInShip:47*vRLo1; viExConPrec)
	vR12:=Round:C94([Item:4]costAverage:13*vRLo1; viExConPrec)
	vR1:=[Item:4]priceA:2
	vR2:=[Item:4]priceB:3
	vR3:=[Item:4]priceC:4
	vR4:=[Item:4]priceD:5
	vR5:=[Item:4]costAverage:13
	vR6:=[Item:4]costLastInShip:47
	Self:C308->:=1
	jCenterWindow(280; 158; -724; "Currency"; "Wind_CloseBox")
	DIALOG:C40([Item:4]; "diaListExch")
	CLOSE WINDOW:C154
	If (myOK=1)
		TRACE:C157
		[Item:4]priceA:2:=vR1
		[Item:4]priceB:3:=vR2
		[Item:4]priceC:4:=vR3
		[Item:4]priceD:5:=vR4
		[Item:4]costAverage:13:=vR5
		[Item:4]costLastInShip:47:=vR6
	End if 
End if 