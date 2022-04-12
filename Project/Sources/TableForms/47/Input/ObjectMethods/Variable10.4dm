READ WRITE:C146([ItemSerial:47])
LOAD RECORD:C52([ItemSerial:47])
C_LONGINT:C283($fileNum)
$k:=Get last field number:C255(->[ItemSerial:47])
$fileNum:=Table:C252(->[ItemSerial:47])
For ($i; 1; $k)
	OBJECT SET ENTERABLE:C238(Field:C253($fileNum; $i)->; True:C214)
End for 
junLockFields
QUERY:C277([ItemSerialAction:64]; [ItemSerialAction:64]ItemSerialID:1=[ItemSerial:47]idUnique:18)