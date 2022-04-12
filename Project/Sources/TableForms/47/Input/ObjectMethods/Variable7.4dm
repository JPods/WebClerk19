KeyModifierCurrent
QUERY:C277([Service:6]; [Service:6]idNum:26=[ItemSerial:47]ideService:54)
If ((Records in selection:C76([Service:6])=0) | (cmdKey=1))
	CREATE RECORD:C68([Service:6])
	
	[Service:6]contactID:52:=[Contact:13]idNum:28
	[Service:6]customerID:1:=[Contact:13]customerID:1
	[Service:6]email:64:=[Contact:13]email:35
	[Service:6]phone:62:=[Contact:13]phone:30
	[Service:6]phoneCell:63:=[Contact:13]phoneCell:52
	[Service:6]zip:60:=[Contact:13]zip:11
	[Service:6]attentionContact:55:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
	[Service:6]repID:2:=[Contact:13]repID:45
	[Service:6]dtBegin:15:=DateTime_Enter
	[Service:6]dtDocument:16:=[Service:6]dtBegin:15
	[Service:6]address1:56:=[Contact:13]address1:6
	[Service:6]address2:57:=[Contact:13]address2:7
	[Service:6]actionCreatedBy:40:=Current user:C182
	SAVE RECORD:C53([Service:6])
	[ItemSerial:47]ideService:54:=[Service:6]idNum:26
	SAVE RECORD:C53([ItemSerial:47])
End if 
ProcessTableOpen(Table:C252(->[Service:6])*-1)