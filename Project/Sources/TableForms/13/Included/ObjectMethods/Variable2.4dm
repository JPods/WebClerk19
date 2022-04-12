iLo20String1:=""
Case of 
	: (Record number:C243([Contact:13])<0)
		
	: ([Contact:13]idNum:28=0)
		
		SAVE RECORD:C53([Contact:13])
	Else 
		If ([Contact:13]idNum:28=[Customer:2]contactBillTo:92)
			iLo20String1:="Bill"
		End if 
		If ([Contact:13]idNum:28=[Customer:2]contactShipTo:93)
			iLo20String1:=iLo20String1+"_Ship"
		End if 
		If ([Contact:13]letterList:13)
			iLo20String1:=iLo20String1+"_Ltr"
		End if 
		If ([Contact:13]optOut:51#"")
			iLo20String1:=iLo20String1+"_OptOut"
		End if 
End case 


iLo20String1:=""
If ([Customer:2]customerID:1=[Contact:13]customerID:1)
	If ([Contact:13]idNum:28=[Customer:2]contactBillTo:92)
		iLo20String1:="Bill2_"
	End if 
	If ([Contact:13]idNum:28=[Customer:2]contactShipTo:93)
		iLo20String1:=iLo20String1+"S"
	End if 
End if 
If ([Contact:13]letterList:13)
	iLo20String1:=iLo20String1+"L"
End if 
If ([Contact:13]optOut:51#"")
	iLo20String1:=iLo20String1+"O"
End if 
//###_jwm_### 20110302 Added leter for FaxList
If ([Contact:13]faxList:42)
	iLo20String1:=iLo20String1+"F"
End if 