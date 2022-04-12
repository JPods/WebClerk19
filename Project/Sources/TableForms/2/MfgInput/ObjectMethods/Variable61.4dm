If (bChangeRec=1)
	[Customer:2]phone:13:=srPhone
Else 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	If (bNewRec=0)
		//    UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]phone:13; ->srPhone)
		booPreNext:=True:C214
	Else 
		If (myDoNew)
			$temp:=srPhone
			Process_AddRecord("Customer")
			srPhone:=$temp
			[Customer:2]phone:13:=srPhone
		End if 
	End if 
End if 