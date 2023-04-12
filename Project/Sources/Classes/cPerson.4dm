Class constructor($firstName : Text; $lastName : Text; $id : Text)
	This:C1470.lastName:=$lastName
	This:C1470.firstName:=$firstName
	This:C1470.id:=$id
	
Function setAddressFromText($working : Text)
	
	
Function getAttention
	Case of 
		: (This:C1470.lastname#Null:C1517)
			$0:=This:C1470.firstName+" "+This:C1470.lastname
		: (This:C1470.attention#Null:C1517)
			$0:=This:C1470.attention
		Else 
			$0:="no attention"
	End case 
	
	
	