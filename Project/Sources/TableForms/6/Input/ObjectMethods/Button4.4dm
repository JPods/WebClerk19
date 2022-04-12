// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/29/06, 15:19:31
// ----------------------------------------------------
// Method: Object Method: iLoInteger1
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($contactPhone)
KeyModifierCurrent
If (([Service:6]phone:62="") | ([Service:6]address1:56="") | ([Service:6]zip:60=""))
	ALERT:C41("A Phone, Address1 and Zip are required to create a new contact.")
Else 
	$contactPhone:=[Service:6]phone:62
	//PUSH RECORD([Contact])
	If (OptKey=1)
		CmdKey:=1
	End if 
	QUERY:C277([Contact:13]; [Contact:13]phone:30=$contactPhone)
	If ((Records in selection:C76([Contact:13])>0) & (CmdKey=0))
		ProcessTableOpen(Table:C252(->[Contact:13])*-1)
	Else 
		CONFIRM:C162("Create a Contact Record.")
		If (OK=1)
			CREATE RECORD:C68([Contact:13])
			
			entryEntity.attentionContact:=Parse_UnWanted(entryEntity.attentionContact)
			[Contact:13]address1:6:=[Service:6]address1:56
			[Contact:13]address2:7:=[Service:6]address2:57
			[Contact:13]city:8:=[Service:6]city:58
			[Contact:13]state:9:=[Service:6]state:59
			[Contact:13]zip:11:=[Service:6]zip:60
			[Contact:13]country:12:=[Service:6]country:61
			[Contact:13]phone:30:=[Service:6]phone:62
			[Contact:13]phoneCell:52:=[Service:6]phoneCell:63
			[Contact:13]profile1:18:=[Service:6]profile1:65
			[Contact:13]profile2:19:=[Service:6]profile2:66
			[Contact:13]email:35:=[Service:6]email:64
			SAVE RECORD:C53([Contact:13])
			[Service:6]contactID:52:=[Contact:13]idNum:28
			SAVE RECORD:C53([Service:6])
			UNLOAD RECORD:C212([Contact:13])
		End if 
	End if 
End if 