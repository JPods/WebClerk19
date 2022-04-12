READ WRITE:C146([ItemSerial:47])
$recCnt:=Records in selection:C76([ItemSerial:47])
FIRST RECORD:C50([ItemSerial:47])
C_LONGINT:C283($i; $k; $recInc; $recCnt)
C_REAL:C285($cost; $price; $claims)
For ($recInc; 1; $recCnt)
	QUERY:C277([ItemSerialAction:64]; [ItemSerialAction:64]ItemSerialID:1=[ItemSerial:47]idUnique:18)
	$k:=Records in selection:C76([ItemSerialAction:64])
	FIRST RECORD:C50([ItemSerialAction:64])
	For ($i; 1; $k)
		If ([ItemSerialAction:64]Claim:13)
			$cost:=$cost+[ItemSerialAction:64]Cost:10
			$price:=$price+[ItemSerialAction:64]Price:12
			$claims:=$claims+1
		End if 
		[ItemSerial:47]ClaimCosts:22:=$cost
		[ItemSerial:47]ClaimPrice:28:=$price
		[ItemSerial:47]ClaimCount:29:=$claims
		SAVE RECORD:C53([ItemSerialAction:64])
		NEXT RECORD:C51([ItemSerialAction:64])
	End for 
	SAVE RECORD:C53([ItemSerial:47])
	NEXT RECORD:C51([ItemSerial:47])
End for 
READ ONLY:C145([ItemSerial:47])