//%attributes = {"publishedWeb":true}
//Procedure: Srl_Reference
Case of 
	: (ptCurTable=(->[Order:3]))
		$theRef:=aoSerialRc{aoLineAction}
	: (ptCurTable=(->[Invoice:26]))
		$theRef:=aiSerialRc{aiLineAction}
	: (ptCurTable=(->[PO:39]))
		$theRef:=aPoSerialRc{aPOLineAction}
End case 
If ($theRef>0)
	ALERT:C41("Existing Serialized items may not be referenced in the same line.")
Else 
	myOk:=15  //flow control
	//jCenterWindow (360;108;1)
	//DIALOG([ItemSerial];"diaRecvSerials")
	Srl_FillRay(0)
	jCenterWindow(560; 440; 1)
	DIALOG:C40([ItemSerial:47]; "diaSerialSet")
	CLOSE WINDOW:C154
	If (myOK=2)
		TRACE:C157
		If ((vsnSrNum#[ItemSerial:47]serialNum:4) | (vSnItmAlpha#[ItemSerial:47]itemNum:1))  //if match not found
			CREATE RECORD:C68([ItemSerial:47])
			
			[ItemSerial:47]itemNum:1:=vSnItmAlpha
			[ItemSerial:47]serialNum:4:=vsnSrNum
			[ItemSerial:47]description:2:=vsnDescript
			[ItemSerial:47]status:8:="Ref"
			[ItemSerial:47]warrantyDays:20:=Num:C11(Request:C163("Remaining warranty days?"))
			$doNew:=True:C214
		End if 
		pSerialNum:=vsnSrNum
		$theDoc:=0
		Case of 
			: (ptCurTable=(->[Order:3]))
				aoSerialRc{aoLineAction}:=-[ItemSerial:47]idNum:18
				aoSerialNm{aoLineAction}:=vsnSrNum
				[ItemSerial:47]customerID:9:=[Customer:2]customerID:1
				$theDoc:=[Order:3]idNum:2
			: (ptCurTable=(->[Invoice:26]))
				aiSerialRc{aiLineAction}:=-[ItemSerial:47]idNum:18
				aiSerialNm{aiLineAction}:=vsnSrNum
				[ItemSerial:47]customerID:9:=[Customer:2]customerID:1
				$theDoc:=[Invoice:26]idNum:2
				//: (ptCurFile=([Proposal]))
				//aPSerialRc{aPLineAction}:=-[ItemSerial]SerialRecordID
				//aPSerialNm{aPLineAction}:=vsnSrNum
				//[ItemSerial]customerID:=[Customer]customerID
				//$theDoc:=0
			: (ptCurTable=(->[PO:39]))
				aPoSerialRc{aPOLineAction}:=-[ItemSerial:47]idNum:18
				//aPoSerialNm{aPOLineAction}:=vsnSrNum
				[ItemSerial:47]vendorID:5:=[Vendor:38]vendorID:1
				$theDoc:=[PO:39]idNum:5
		End case 
		Srl_Transaction(Table:C252(ptCurTable); $theDoc; True:C214; "Reference")
		SAVE RECORD:C53([ItemSerial:47])
		
		UNLOAD RECORD:C212([Item:4])
		UNLOAD RECORD:C212([ItemSerial:47])
	End if 
End if 
myOk:=0