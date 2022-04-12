//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //delete this is likely
TRACE:C157
TRACE:C157
QUERY:C277([ItemSerial:47]; [ItemSerial:47]idNum:18=$1)
LOAD RECORD:C52([ItemSerial:47])
If (Not:C34(Locked:C147([ItemSerial:47])))
	[ItemSerial:47]status:8:="Av"
	[ItemSerial:47]customerid:9:=""
	[ItemSerial:47]invoiceNum:10:=0
	[ItemSerial:47]salesLnRefid:11:=0
	SAVE RECORD:C53([ItemSerial:47])
Else 
	ALERT:C41("")
End if 