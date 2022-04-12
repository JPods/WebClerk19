//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //index into aLI arrays
READ WRITE:C146([ItemSerial:47])
CREATE RECORD:C68([ItemSerial:47])

[ItemSerial:47]status:8:="Ps"
[ItemSerial:47]itemNum:1:=aiItemNum{$1}
[ItemSerial:47]description:2:=aiDescpt{$1}  //aLIDescrpt{$1}
[ItemSerial:47]customerID:9:=[Invoice:26]customerID:3  //[Sale]AccountNum
[ItemSerial:47]dateShipped:13:=[Invoice:26]dateShipped:4  //[Sale]TransactionDate
[ItemSerial:47]invoiceNum:10:=[Invoice:26]invoiceNum:2  //[Sale]salesNameID
[ItemSerial:47]salesLnRefid:11:=aiLineNum{$1}  //aLILineNum{$1}
[ItemSerial:47]serialNum:4:="TBD"
[ItemSerial:47]modelNum:3:="Override by "+Current user:C182
[ItemSerial:47]poLnRefid:7:=0
[ItemSerial:47]poNum:6:=0
[ItemSerial:47]vendorID:5:=""
[ItemSerial:47]dateReceived:12:=Current date:C33
[ItemSerial:47]floorPlanid:14:=""
[ItemSerial:47]fPExpireDate:15:=!00-00-00!
[ItemSerial:47]daysOnPlan:17:=0
[ItemSerial:47]dateWarrantyEnd:21:=Current date:C33+[ItemSerial:47]warrantyDays:20
SAVE RECORD:C53([ItemSerial:47])
aiSerialRc{$1}:=[ItemSerial:47]idNum:18
//aCounterNew{File([ItemSerial])}:=0
UNLOAD RECORD:C212([ItemSerial:47])
READ ONLY:C145([ItemSerial:47])