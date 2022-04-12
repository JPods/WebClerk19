If ([QQQCurrency:61]ExchangeRate:4=0)
	[QQQCurrency:61]ExchangeRate:4:=1
Else 
	vrLo1:=Round:C94(1/[QQQCurrency:61]ExchangeRate:4; [QQQCurrency:61]ConvertPrec:7)
End if 
// // zzzqqq U_DTStampFldMod (->[Currency]Comment;->[Currency]TimeLastUpdated)