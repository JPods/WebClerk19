// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/16/10, 08:34:31
// ----------------------------------------------------
// Method: Object Method: [Order].iOrders_9.aContact
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (aContact>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactUnique{aContact})  // Replaced GOTO Record in Selection
	// QUERY([Contact];[Contact]UniqueID=aContactUniqueID{aContact}) Cannot be used because it is all contracts 
	// QUERY([Contact];[Contact]UniqueID=aContactUnique{aContact})  // Replaced GOTO Record in Selection
	[Order:3]orderedBy:66:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
	
	If (Not:C34(<>vConfirmEmailSkip))
		If ([Contact:13]email:35#"")
			If ([Order:3]email:82#"")
				CONFIRM:C162("Change  Order Email Address"+"\r"+"\r"+"from "+[Order:3]email:82+" to "+[Contact:13]email:35; " Change "; " Cancel ")
			Else 
				CONFIRM:C162("Change  Order Email Address"+"\r"+"\r"+"from 'NO EMAIL ADDRESS' to "+[Contact:13]email:35; " Change "; " Cancel ")
			End if 
			If (ok=1)
				[Order:3]email:82:=[Contact:13]email:35
			End if 
		Else 
			ALERT:C41("There is NO EMAIL ADDRESS for "+[Order:3]orderedBy:66)
		End if 
	Else 
		[Order:3]email:82:=[Contact:13]email:35
	End if 
End if 