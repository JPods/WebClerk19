//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/22/19, 08:51:32
// ----------------------------------------------------
// Method: CustomerAlert
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### jwm ### 20190424_1038 Alert if not EDI and in the input layout
If (Modified:C32([Order:3]customerid:1) & (Old:C35([Order:3]customerid:1)#[Order:3]customerid:1))
	If ([Customer:2]alertMessage:79#"")
		ALERT:C41([Customer:2]alertMessage:79)
	End if 
End if 