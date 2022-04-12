//%attributes = {}

// Modified by: Bill James (2021-12-07T06:00:00Z)
// Method: Customer_LockSet
// Description 
// Parameters
// ----------------------------------------------------


If (Locked:C147([Customer:2]))
	SET WINDOW TITLE:C213("LOCKED: Customer")  //+$locked)
	OBJECT SET RGB COLORS:C628(*; "srCustomer"; Yellow:K11:2; Red:K11:4)
Else 
	Set_Window_Title(->[Customer:2])
	OBJECT SET RGB COLORS:C628(*; "srCustomer"; Black:K11:16; White:K11:1)
End if 
