
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/19/16, 12:39:21
// ----------------------------------------------------
// Method: [Item].Input.Field8
// Description
// 
//
// Parameters
// ----------------------------------------------------


If ([Item:4]retired:64)
	If ([Item:4]publish:60>0)
		CONFIRM:C162("Set Web Publish to zero?"; "No Change"; "Set to 0")
		If (OK=0)
			[Item:4]publish:60:=0
		End if 
	End if 
Else 
	ALERT:C41("Set web publish level as needed.")
End if 

If ([Item:4]dateRetired:122=!00-00-00!)
	CONFIRM:C162("Retire this Item."; " Retire "; " Cancel ")
	If (OK=1)
		[Item:4]dateRetired:122:=Current date:C33
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
		$k:=Records in selection:C76([Contact:13])
		FIRST RECORD:C50([Contact:13])
		For ($i; 1; $k)
			[Contact:13]dateRetired:57:=[Item:4]dateRetired:122
			SAVE RECORD:C53([Contact:13])
			NEXT RECORD:C51([Contact:13])
		End for 
		//bRetired:=1
	End if 
Else 
	CONFIRM:C162("Reactivate this Item."; " Reactivate "; " Cancel ")
	If (OK=1)
		[Item:4]dateRetired:122:=!00-00-00!
		//bRetired:=0
	End if 
End if 