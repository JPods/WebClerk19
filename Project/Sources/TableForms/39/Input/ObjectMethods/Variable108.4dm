If ([PO:39]shipToCompany:8#"")
	CREATE RECORD:C68([Customer:2])
	[Customer:2]customerID:1:=String:C10(CounterNew(->[Customer:2]); "0000000")
	[Customer:2]company:2:=[PO:39]shipToCompany:8
	[Customer:2]address1:4:=[PO:39]address1:9
	[Customer:2]address2:5:=[PO:39]address2:10
	[Customer:2]city:6:=[PO:39]city:11
	[Customer:2]state:7:=[PO:39]state:12
	[Customer:2]country:9:=[PO:39]country:14
	[Customer:2]shipVia:12:=[PO:39]shipVia:33
	[Customer:2]shipInstruct:24:=[PO:39]shipInstruct:31
	entryEntity.attention:=Parse_UnWanted(entryEntity.attention)
	[Customer:2]zip:8:=[PO:39]zip:13
	[Customer:2]phone:13:=[PO:39]phone:15
	[Customer:2]dateOpened:14:=Current date:C33
	[Customer:2]terms:33:=<>vTerms
	[Customer:2]repID:58:=[PO:39]salesNameID:35
	[Customer:2]typeSale:18:=<>vTypeSale
	[Customer:2]prospect:17:="Lead"
	[Customer:2]division:70:=GL_GetDivsnDflt
	[Customer:2]zone:57:=-1
	//  [Customer]MfrLocationID:=vOpenItem
	SAVE RECORD:C53([Customer:2])
Else 
	jAlertMessage(9210)
End if 