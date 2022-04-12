Case of 
	: (Before:C29)
		If ([InventoryStack:29]idUnique:1=0)
			[InventoryStack:29]DateEntered:3:=Current date:C33
			
		Else 
			RELATE ONE:C42([InventoryStack:29]ItemNum:2)
		End if 
End case 