
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/07/17, 11:09:43
// ----------------------------------------------------
// Method: entryEntity..Input1.Variable143
// Description
// This is the actoin of retiring the customer on the form
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171207_1110 New method AcceptContactsRetired called in jAcceptButton and WccAcceptTasks to update [Contact]DateRetired

If ([QQQCustomer:2]dateRetired:111=!00-00-00!)
	CONFIRM:C162("Retire this Customer and Contacts."; "OK"; "Cancel")
	If (OK=1)
		[QQQCustomer:2]dateRetired:111:=Current date:C33
	Else 
		CONFIRM:C162("Reactivate this Customer."; "Reactivate"; "Cancel")
		If (OK=1)
			[QQQCustomer:2]dateRetired:111:=!00-00-00!
		End if 
	End if 
End if 
