//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/03/21, 20:45:15
// ----------------------------------------------------
// Method: Acme_DeleteKey
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($keyDir_t; $1)
If (Count parameters:C259=1)
	$keyDir_t:=$1
	If (Test path name:C476($keyDir_t+"key.pem")=Is a document:K24:1)
		DELETE DOCUMENT:C159($keyDir_t+"key.pem")
	End if 
	If (Test path name:C476($keyDir_t+"key.pub")=Is a document:K24:1)
		DELETE DOCUMENT:C159($keyDir_t+"key.pub")
	End if 
End if 