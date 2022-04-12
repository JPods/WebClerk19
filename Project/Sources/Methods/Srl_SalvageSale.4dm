//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //SerialRecordID
C_POINTER:C301($2)  //pt to 
READ WRITE:C146([ItemSerial:47])
$doSave:=False:C215
QUERY:C277([ItemSerial:47]; [ItemSerial:47]salesLnRefid:11=$1)
$k:=Records in selection:C76([ItemSerial:47])
FIRST RECORD:C50([ItemSerial:47])
For ($i; 1; $k)
	CREATE RECORD:C68([ItemSerialAction:64])
	
	[ItemSerialAction:64]itemSerialid:1:=[ItemSerial:47]idNum:18
	[ItemSerialAction:64]serialNum:2:=[ItemSerial:47]serialNum:4
	[ItemSerialAction:64]itemNum:8:=[ItemSerial:47]itemNum:1
	[ItemSerialAction:64]action:7:="Returned in invoice"
	[ItemSerialAction:64]dateAction:6:=Current date:C33
	[ItemSerialAction:64]tableNum:3:=Table:C252($2)  //filenum
	[ItemSerialAction:64]docid:4:=$2->  //[Invoice]InvoiceNum
	SAVE RECORD:C53([ItemSerialAction:64])
	//add a split for  changes
	[ItemSerial:47]status:8:="Av"
	[ItemSerial:47]customerid:9:=""
	[ItemSerial:47]dateShipped:13:=!00-00-00!
	[ItemSerial:47]invoiceNum:10:=0
	[ItemSerial:47]salesLnRefid:11:=0
	[ItemSerial:47]daysOnPlan:17:=0
	[ItemSerial:47]dateWarrantyEnd:21:=!00-00-00!
	SAVE RECORD:C53([ItemSerial:47])
	NEXT RECORD:C51([ItemSerial:47])
End for 
UNLOAD RECORD:C212([ItemSerial:47])
READ ONLY:C145([ItemSerial:47])
UNLOAD RECORD:C212([ItemSerialAction:64])