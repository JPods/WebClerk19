If (bChangeRec=1)
	[Customer:2]zip:8:=srZip
	Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
Else 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	If (bNewRec=0)
		//    UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]zip:8; ->srZip)
		booPreNext:=True:C214
	Else 
		If (myDoNew)
			$temp:=srZip
			Process_AddRecord("Customer")
			srZip:=$temp
			[Customer:2]zip:8:=srZip
		End if 
	End if 
End if 