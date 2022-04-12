//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:46:56
// ----------------------------------------------------
// Method: TermsPopup
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Term"))
	C_POINTER:C301($1; $2; $3; $4)
	jPopUpArray(-><>aTerms; $1)
	If (Count parameters:C259=4)
		Copy_NewEntry($2; $3; $4)
	End if 
End if 
