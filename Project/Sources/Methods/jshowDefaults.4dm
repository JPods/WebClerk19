//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:34:50
// ----------------------------------------------------
// Method: jshowDefaults
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Employee"))
	
	jsetDefaultFile(->[Default:15])
	READ WRITE:C146([Default:15])
	QUERY:C277([Default:15]; [Default:15]primeDefault:176=1)
	ProcessTableOpen(->[Default:15])
End if 