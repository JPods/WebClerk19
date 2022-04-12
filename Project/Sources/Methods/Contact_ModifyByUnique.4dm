//%attributes = {"publishedWeb":true}
//Method: Contact_ModifyByUnique
C_POINTER:C301($1)
If ($1-><1)
	Case of 
		: ($1=(->[Customer:2]contactBillTo:92))
			If (Record number:C243([Contact:13])>-1)
				CONFIRM:C162("Set Primary Bill To: "+[Contact:13]address1:6+", "+[Contact:13]zip:11)
				If (OK=1)
					[Customer:2]contactBillTo:92:=[Contact:13]idNum:28
				End if 
			Else 
				ALERT:C41("No Contact Selected.")
			End if 
		: ($1=(->[Customer:2]contactShipTo:93))
			If (Record number:C243([Contact:13])>-1)
				CONFIRM:C162("Set Primary Ship To: "+[Contact:13]address1:6+", "+[Contact:13]zip:11)
				If (OK=1)
					[Customer:2]contactBillTo:92:=[Contact:13]idNum:28
				End if 
			Else 
				ALERT:C41("No Contact Selected.")
			End if 
	End case 
Else 
	C_LONGINT:C283($w)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=$1->)
	If (Records in selection:C76([Contact:13])=1)
		KeyModifierCurrent
		If (optKey=0)
			READ ONLY:C145([Customer:2])
			LOAD RECORD:C52([Customer:2])
			Set_Window_Title(ptCurTable)
			ProcessTableOpen(Table:C252(->[Contact:13])*-1)
		Else 
			MODIFY RECORD:C57([Contact:13])
			//watch out for vHere aspects
			REDUCE SELECTION:C351([Contact:13]; 0)
			//  CHOPPED  ContactsLoad(-1)
		End if 
	End if 
End if 
