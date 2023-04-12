//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/31/11, 07:03:28
// ----------------------------------------------------
// Method: Contact_FillFrom
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

Case of 
	: (($1=(->[Customer:2])) | (($1=(->[Base:1])) & (Record number:C243([Customer:2])>-1)) | (($1=(->[Contact:13])) & (Record number:C243([Customer:2])>-1)))
		[Contact:13]title:5:=[Customer:2]title:3
		[Contact:13]nameFirst:2:=[Customer:2]nameFirst:73
		[Contact:13]nameLast:4:=[Customer:2]nameLast:23
		[Contact:13]fax:31:=[Customer:2]fax:66
		[Contact:13]phone:30:=[Customer:2]phone:13
		[Contact:13]phoneCell:52:=[Customer:2]phoneCell:99
		[Contact:13]email:35:=[Customer:2]email:81
		Contact_FillRec(->[Customer:2]shipVia:12; ->[Customer:2]company:2; ->[Customer:2]address1:4; ->[Customer:2]address2:5; ->[Customer:2]city:6; ->[Customer:2]state:7; ->[Customer:2]zip:8; ->[Customer:2]country:9; ->[Customer:2]taxJuris:65; ->[Customer:2]zone:57; ->[Customer:2]customerID:1; ->[Customer:2]nameFirst:73; ->[Customer:2]nameLast:23; ->[Customer:2]email:81)
	: ($1=(->[Order:3]))
		Parse_UnWanted(process_o.entry_o.attention)
		If ([Order:3]email:82="")
			iLoText1:=[Customer:2]email:81
		Else 
			iLoText1:=[Order:3]email:82
		End if 
		Contact_FillRec(->[Order:3]shipVia:13; ->[Order:3]company:15; ->[Order:3]address1:16; ->[Order:3]address2:17; ->[Order:3]city:18; ->[Order:3]state:19; ->[Order:3]zip:20; ->[Order:3]country:21; ->[Order:3]taxJuris:43; ->[Order:3]zone:14; ->[Customer:2]customerID:1; ->[Contact:13]nameFirst:2; ->[Contact:13]nameLast:4; ->iLoText1)
	: ($1=(->[Invoice:26]))
		If ([Invoice:26]email:76="")
			iLoText1:=[Customer:2]email:81
		Else 
			iLoText1:=[Invoice:26]email:76
		End if 
		Parse_UnWanted(process_o.entry_o.attention)
		Contact_FillRec(->[Invoice:26]shipVia:5; ->[Invoice:26]company:7; ->[Invoice:26]address1:8; ->[Invoice:26]address2:9; ->[Invoice:26]city:10; ->[Invoice:26]state:11; ->[Invoice:26]zip:12; ->[Invoice:26]country:13; ->[Invoice:26]taxJuris:33; ->[Invoice:26]zone:6; ->[Customer:2]customerID:1; ->[Contact:13]nameFirst:2; ->[Contact:13]nameLast:4; ->iLoText1)
	: ($1=(->[Proposal:42]))
		If ([Proposal:42]email:68="")
			iLoText1:=[Customer:2]email:81
		Else 
			iLoText1:=[Proposal:42]email:68
		End if 
		Parse_UnWanted(process_o.entry_o.attention)
		Contact_FillRec(->[Proposal:42]shipVia:18; ->[Proposal:42]company:11; ->[Proposal:42]address1:12; ->[Proposal:42]address2:13; ->[Proposal:42]city:14; ->[Proposal:42]state:15; ->[Proposal:42]zip:16; ->[Proposal:42]country:17; ->[Proposal:42]taxJuris:33; ->[Proposal:42]zone:19; ->[Customer:2]customerID:1; ->[Contact:13]nameFirst:2; ->[Contact:13]nameLast:4; ->iLoText1)
	: ($1=(->[Service:6]))
		If (Record number:C243([Customer:2])>-1)
			If ([Service:6]email:64="")
				iLoText1:=[Customer:2]email:81
			Else 
				iLoText1:=[Service:6]email:64
			End if 
			Contact_FillRec(->[Customer:2]shipVia:12; ->[Customer:2]company:2; ->[Customer:2]address1:4; ->[Customer:2]address2:5; ->[Customer:2]city:6; ->[Customer:2]state:7; ->[Customer:2]zip:8; ->[Customer:2]country:9; ->[Customer:2]taxJuris:65; ->[Customer:2]zone:57; ->[Customer:2]customerID:1; ->[Customer:2]nameFirst:73; ->[Customer:2]nameLast:23; ->iLoText1)
		End if 
		If ([Service:6]attention:30#"")
			Parse_UnWanted(process_o.entry_o.attention)
		End if 
End case 