//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-22T00:00:00, 13:57:33
// ----------------------------------------------------
// Method: PageParameterGet

// Description
// Modified: 12/22/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160218_0903 added default parameter

// $1 -> param to get
// $2 -> default value
// $0 <- result

// THIS HAS BEEN DEPRECIATED IN FAVOR OF WCapi_GetParameter. IT IS
// BEING KEPT RIGHT NOW AS AN ALIAS.

C_TEXT:C284($0; $1; $2)
If (Count parameters:C259>1)
	$0:=WCapi_GetParameter($1; $2)
Else 
	$0:=WCapi_GetParameter($1)
End if 