//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)  //was the serial number deleted
C_LONGINT:C283($1)  //serial record number
$0:=False:C215  //assume false
QUERY:C277([ItemSerial:47]; [ItemSerial:47]idUnique:18=$1)
If (Records in selection:C76([ItemSerial:47])=1)
	If ([ItemSerial:47]Status:8#"P@")
		//delete previously recieved Serial number    
		LOAD RECORD:C52([ItemSerial:47])
		If (Locked:C147([ItemSerial:47]))
			[TempRec:55]tableNum:1:=Table:C252(->[ItemSerial:47])
			[TempRec:55]RecordNumOrig:2:=-Record number:C243([ItemSerial:47])  //<0 delete
			SAVE RECORD:C53([TempRec:55])
		Else 
			DELETE RECORD:C58([ItemSerial:47])
		End if 
		$0:=True:C214
	End if 
End if 