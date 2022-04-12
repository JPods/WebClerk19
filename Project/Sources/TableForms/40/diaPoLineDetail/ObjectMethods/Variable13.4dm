//If ((<>vbDoSrlNums)&(pSerialized#<>ciSRNotSerialized))
//PoLineRecv 
//End if 
TRACE:C157
$SerialNum:=Request:C163("Enter Serial Number to Reference.")
QUERY:C277([ItemSerial:47]; [ItemSerial:47]SerialNum:4=$SerialNum; *)
QUERY:C277([ItemSerial:47];  & [ItemSerial:47]ItemNum:1=pPartNum)
C_LONGINT:C283($theRef)
Case of 
	: (Records in selection:C76([ItemSerial:47])=1)
		$theRef:=-[ItemSerial:47]idUnique:18
	: (Records in selection:C76([ItemSerial:47])=0)
		ALERT:C41("Serial number is not in the system.")
		$theRef:=-7
	: (Records in selection:C76([ItemSerial:47])>1)
		ALERT:C41("Multiple records match.")
		$theRef:=-8
End case 
If (ptCurTable=(->[Order:3]))
	pSerialNum:=$SerialNum
	aoSerialRc{aoLineAction}:=$theRef
Else 
	pSerialNum:=$SerialNum
	aiSerialRc{aiLineAction}:=$theRef
End if 
UNLOAD RECORD:C212([ItemSerial:47])