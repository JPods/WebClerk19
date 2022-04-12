//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/21/19, 21:04:30
// ----------------------------------------------------
// Method: SortButton
// Description
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Count parameters:C259>=1)
			ClickToSort($1)
		Else 
			ClickToSort
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		SetColumnTitle
		
End case 
