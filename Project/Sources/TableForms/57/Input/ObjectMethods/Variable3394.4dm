KeyModifierCurrent
If (OptKey=0)
	[RemoteUser:57]email:14:=Self:C308->
End if 
If ([RemoteUser:57]userName:2="")
	[RemoteUser:57]userName:2:=[RemoteUser:57]email:14
End if 

Case of 
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Customer:2]))
		
		If ([RemoteUser:57]customerid:10#[Customer:2]customerID:1)
			COPY NAMED SELECTION:C331([Customer:2]; "Current_Customers")
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerid:10)
			// zzzqqq U_DTStampFldMod(->[Customer:2]comment:15; ->[RemoteUser:57]email:14)
			SAVE RECORD:C53([Customer:2])
			USE NAMED SELECTION:C332("Current_Customers")
			CLEAR NAMED SELECTION:C333("Current_Customers")
		Else 
			// zzzqqq U_DTStampFldMod(->[Customer:2]comment:15; ->[RemoteUser:57]email:14)
			SAVE RECORD:C53([Customer:2])
			
		End if 
		
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
		
		If ([RemoteUser:57]customerid:10#String:C10([Contact:13]idNum:28))
			COPY NAMED SELECTION:C331([Contact:13]; "Current_Contacts")
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=[RemoteUser:57]customerid:10)
			// zzzqqq U_DTStampFldMod(->[Contact:13]comment:29; ->[RemoteUser:57]email:14)
			SAVE RECORD:C53([Contact:13])
			USE NAMED SELECTION:C332("Current_Contacts")
			CLEAR NAMED SELECTION:C333("Current_Contacts")
		Else 
			// zzzqqq U_DTStampFldMod(->[Contact:13]comment:29; ->[RemoteUser:57]email:14)
			SAVE RECORD:C53([Contact:13])
		End if 
		
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Lead:48]))
		
		If ([RemoteUser:57]customerid:10#String:C10([Lead:48]idNum:32))
			COPY NAMED SELECTION:C331([Lead:48]; "Current_Leads")
			QUERY:C277([Customer:2]; [Lead:48]idNum:32=[RemoteUser:57]customerid:10)
			// zzzqqq U_DTStampFldMod(->[Lead:48]comment:24; ->[RemoteUser:57]email:14)
			SAVE RECORD:C53([Lead:48])
			USE NAMED SELECTION:C332("Current_Leads")
			CLEAR NAMED SELECTION:C333("Current_Leads")
		Else 
			// zzzqqq U_DTStampFldMod(->[Lead:48]comment:24; ->[RemoteUser:57]email:14)
			SAVE RECORD:C53([Lead:48])
		End if 
		
End case 