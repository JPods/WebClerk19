
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/01/20, 18:15:48
// ----------------------------------------------------
// Method: [QACustomer].Input.Variable14103
// Description
// 
//
// Parameters
// ----------------------------------------------------
CONFIRM:C162("Change image path?")
If (OK=1)
	READ PICTURE FILE:C678(""; vItemPict; *)
	If (OK=1)
		[QACustomer:70]photo:19:=Convert path system to POSIX:C1106(document)
		SAVE RECORD:C53([QACustomer:70])
	End if 
End if 

