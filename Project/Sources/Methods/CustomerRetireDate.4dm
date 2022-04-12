//%attributes = {}
If ([Customer:2]dateRetired:111=!00-00-00!)
	CONFIRM:C162("Retire this Customer and Contacts."; "OK"; "Cancel")
	If (OK=1)
		[Customer:2]dateRetired:111:=Current date:C33
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
		$k:=Records in selection:C76([Contact:13])
		FIRST RECORD:C50([Contact:13])
		For ($i; 1; $k)
			[Contact:13]dateRetired:57:=[Customer:2]dateRetired:111
			SAVE RECORD:C53([Contact:13])
			NEXT RECORD:C51([Contact:13])
		End for 
	End if 
Else 
	CONFIRM:C162("Reactivate this Customer."; "Reactivate"; "Cancel")
	If (OK=1)
		[Customer:2]dateRetired:111:=!00-00-00!
	End if 
End if 
bRetired:=Num:C11([Customer:2]dateRetired:111#!00-00-00!)