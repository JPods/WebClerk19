//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 01:56:46
// ----------------------------------------------------
// Method: Ex_FixCurrency
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1)
TRACE:C157
TRACE:C157
//Fix Balance Due
TRACE:C157
Case of 
	: ($1=3)
		vi2:=Records in selection:C76([Order:3])
		FIRST RECORD:C50([Order:3])
		For (vi1; 1; vi2)
			If (([Order:3]currency:69#"") & ([Order:3]exchangeRate:68#1) & ([Order:3]exchangeRate:68#0))
				QUERY:C277([QQQCurrency:61]; [QQQCurrency:61]CurrencyID:3=[Order:3]currency:69; *)
				QUERY:C277([QQQCurrency:61];  & [QQQCurrency:61]Active:2=True:C214)
				viExConPrec:=[QQQCurrency:61]ConvertPrec:7
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
				vi4:=Records in selection:C76([OrderLine:49])
				FIRST RECORD:C50([OrderLine:49])
				For (vi3; 1; vi4)
					[OrderLine:49]unitPrice:9:=Round:C94([OrderLine:49]unitPrice:9/[Order:3]exchangeRate:68; viExConPrec)
					[OrderLine:49]unitCost:12:=Round:C94([OrderLine:49]unitCost:12/[Order:3]exchangeRate:68; viExConPrec)
					NEXT RECORD:C51([OrderLine:49])
				End for 
				SAVE RECORD:C53([Order:3])
				OrdLnFillRays
				vMod:=calcOrder(True:C214)
				booAccept:=True:C214
				acceptOrders
			End if 
			NEXT RECORD:C51([Order:3])
		End for 
	: ($1=26)
		//
		
	: ($1=3)
		
	: ($1=3)
		
End case 