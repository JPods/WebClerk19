QUERY:C277([ItemSerialAction:64]; [ItemSerialAction:64]ItemSerialID:1=[ItemSerial:47]idUnique:18)
C_LONGINT:C283($i; $k)
READ WRITE:C146([ItemSerial:47])
LOAD RECORD:C52([ItemSerial:47])
C_REAL:C285($cost; $price; $claims)
$k:=Records in selection:C76([ItemSerialAction:64])
FIRST RECORD:C50([ItemSerialAction:64])
For ($i; 1; $k)
	If ([ItemSerialAction:64]Claim:13)
		$price:=$price+[ItemSerialAction:64]Price:12
		$cost:=$cost+[ItemSerialAction:64]Cost:10
		$claims:=$claims+1
	End if 
	NEXT RECORD:C51([ItemSerialAction:64])
End for 
[ItemSerial:47]ClaimCosts:22:=$cost
[ItemSerial:47]ClaimPrice:28:=$price
[ItemSerial:47]ClaimCount:29:=$claims
SAVE RECORD:C53([ItemSerialAction:64])
READ ONLY:C145([ItemSerial:47])