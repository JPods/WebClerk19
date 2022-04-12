//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2)
READ WRITE:C146([ItemSerial:47])
QUERY:C277([ItemSerial:47]; [ItemSerial:47]idNum:18=$1)
LOAD RECORD:C52([ItemSerial:47])
If (Locked:C147([ItemSerial:47]))
	CREATE RECORD:C68([TempRec:55])
	[TempRec:55]tableNum:1:=Table:C252(->[ItemSerial:47])
	[TempRec:55]recordNumOrig:2:=-Record number:C243([ItemSerial:47])  //<0 delete orginal
	DUPLICATE RECORD:C225([ItemSerial:47])
	SAVE RECORD:C53([ItemSerial:47])
	[TempRec:55]recordNumNew:3:=Record number:C243([ItemSerial:47])
	SAVE RECORD:C53([TempRec:55])
	UNLOAD RECORD:C212([TempRec:55])
End if 
[ItemSerial:47]status:8:="Iv"
[ItemSerial:47]customerID:9:=[Invoice:26]customerID:3
[ItemSerial:47]dateShipped:13:=[Invoice:26]dateShipped:4  //[Sale]TransactionDate
[ItemSerial:47]invoiceNum:10:=[Invoice:26]invoiceNum:2  //[Sale]salesNameID
[ItemSerial:47]salesLnRefid:11:=aiLineNum{$2}
If (([ItemSerial:47]dateShipped:13#!00-00-00!) & ([ItemSerial:47]dateReceived:12#!00-00-00!))
	[ItemSerial:47]daysOnPlan:17:=[ItemSerial:47]dateShipped:13-[ItemSerial:47]dateReceived:12
Else 
	[ItemSerial:47]daysOnPlan:17:=0
End if 
[ItemSerial:47]dateWarrantyEnd:21:=Current date:C33+[ItemSerial:47]warrantyDays:20
[ItemSerial:47]cost:24:=aiUnitCost{$2}
[ItemSerial:47]discount:25:=aiDiscnt{$2}
[ItemSerial:47]price:26:=aiUnitPrice{$2}
//
CREATE RECORD:C68([ItemSerialAction:64])

[ItemSerialAction:64]itemSerialid:1:=Abs:C99([ItemSerial:47]idNum:18)
[ItemSerialAction:64]serialNum:2:=[ItemSerial:47]serialNum:4
[ItemSerialAction:64]itemNum:8:=[ItemSerial:47]itemNum:1
[ItemSerialAction:64]action:7:="Issued in invoice"
[ItemSerialAction:64]dateAction:6:=Current date:C33
[ItemSerialAction:64]tableNum:3:=Table:C252(->[Invoice:26])
[ItemSerialAction:64]docid:4:=[Invoice:26]invoiceNum:2
SAVE RECORD:C53([ItemSerialAction:64])
SAVE RECORD:C53([ItemSerial:47])
UNLOAD RECORD:C212([ItemSerial:47])
READ ONLY:C145([ItemSerial:47])