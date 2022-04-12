If (False:C215)
	//[Employee]  Object Method: Active
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//TRACE
//
C_BOOLEAN:C305(<>PasswordAuto)
If (<>PasswordAuto)
	If ([Employee:19]active:12)
		If ([Employee:19]nameid:1#"")
			PassWordCreate(2)
			jpwCreate
		Else 
			ALERT:C41("Define nameID first.")
		End if 
	Else 
		PassWordCreate(3)  //delete password
	End if 
End if 