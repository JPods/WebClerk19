CONFIRM:C162("Confirm, query for Contact Record?")
If (OK=1)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Service:6]contactid:52)
	If (Records in selection:C76([Contact:13])=1)
		[Service:6]contactid:52:=[Contact:13]idNum:28
		[Service:6]address1:56:=[Contact:13]address1:6
		[Service:6]address2:57:=[Contact:13]address2:7
		[Service:6]attentionContact:55:=[Contact:13]nameLast:4+", "+[Contact:13]nameFirst:2
		[Service:6]city:58:=[Contact:13]city:8
		[Service:6]state:59:=[Contact:13]state:9
		[Service:6]zip:60:=[Contact:13]zip:11
		[Service:6]phoneCell:63:=[Contact:13]phoneCell:52
		[Service:6]phone:62:=[Contact:13]phone:30
		[Service:6]email:64:=[Contact:13]email:35
		[Service:6]country:61:=[Contact:13]country:12
		//SAVE RECORD([Service])
	Else 
		ALERT:C41("There was no matching contact record.")
	End if 
End if 