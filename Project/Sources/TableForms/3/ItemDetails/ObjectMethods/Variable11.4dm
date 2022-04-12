C_LONGINT:C283($srlRec)
$gotSRL:=False:C215
QUERY:C277([ItemSerial:47]; [ItemSerial:47]SerialNum:4=pSerialNum)
Case of 
	: (Records in selection:C76([ItemSerial:47])=1)
		$theItem:=[ItemSerial:47]ItemNum:1
		$gotSRL:=True:C214
	: (Records in selection:C76([ItemSerial:47])>1)
		$theItem:=Request:C163("Enter Item Num for "+pSerialNum)
		If (OK=1)
			QUERY:C277([ItemSerial:47]; [ItemSerial:47]SerialNum:4=pSerialNum; *)
			QUERY:C277([ItemSerial:47];  & [ItemSerial:47]ItemNum:1=$theItem)
			If (Records in selection:C76([ItemSerial:47])=1)
				$gotSRL:=True:C214
			End if 
		End if 
End case 
If ($gotSRL=False:C215)
	ALERT:C41("Item number or unique serial number not found")
	$srlRec:=-1
Else 
	$srlRec:=-[ItemSerial:47]idUnique:18
End if 
Case of 
	: (ptCurTable=(->[Order:3]))
		aoSerialRc{aoLineAction}:=$srlRec
		aoSerialNm{aoLineAction}:=pSerialNum
	: (ptCurTable=(->[Invoice:26]))
		aiSerialRc{aiLineAction}:=$srlRec
		aiSerialNm{aiLineAction}:=pSerialNum
End case 