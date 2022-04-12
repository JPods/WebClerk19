If (bChangeRec=1)
	[Customer:2]zip:8:=srZip
	Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteid:106)
Else 
	SrCustomerRec(->[Customer:2]; ->[Customer:2]zip:8; ->srZip; bChangeRec; False:C215)
End if 