If ([RemoteUser:57]tableNum:9>0)
	If (Records in selection:C76(Table:C252([RemoteUser:57]tableNum:9)->)>0)
		DB_ShowCurrentSelection(Table:C252([RemoteUser:57]tableNum:9); ""; 1; "")
	End if 
End if 