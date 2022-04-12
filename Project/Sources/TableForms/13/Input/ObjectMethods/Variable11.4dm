If ([Contact:13]email:35="")
	iLoText1:=[Customer:2]email:81
Else 
	iLoText1:=[Contact:13]email:35
End if 
Contact_FillRec(->[Customer:2]shipVia:12; ->[Customer:2]company:2; ->[Customer:2]address1:4; ->[Customer:2]address2:5; ->[Customer:2]city:6; ->[Customer:2]state:7; ->[Customer:2]zip:8; ->[Customer:2]country:9; ->[Customer:2]taxJuris:65; ->[Customer:2]zone:57; ->[Customer:2]customerID:1; ->[Contact:13]nameFirst:2; ->[Contact:13]nameLast:4; ->iLoText1)
iLoText1:=""