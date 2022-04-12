If (bChangeRec=1)
	jUniqueAcctCode(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct)
Else 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	If (bNewRec=0)
		//    UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct)
		booPreNext:=True:C214
	Else 
		If (myDoNew)
			Process_AddRecord("Customer")
		End if 
	End if 
End if 