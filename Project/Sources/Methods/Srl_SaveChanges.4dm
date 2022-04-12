//%attributes = {"publishedWeb":true}
If (Record number:C243([ItemSerial:47])>-1)
	READ WRITE:C146([ItemSerial:47])
	LOAD RECORD:C52([ItemSerial:47])
	[ItemSerial:47]ClaimCosts:22:=vClaim
	SAVE RECORD:C53([ItemSerial:47])
	READ ONLY:C145([ItemSerial:47])
End if 