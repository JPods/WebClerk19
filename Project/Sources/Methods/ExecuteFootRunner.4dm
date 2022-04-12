//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-08-02T00:00:00, 11:12:02
// ----------------------------------------------------
// Method: ExecuteFootRunner
// Description
// Modified: 08/02/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
If ($1#"")
	ExecuteText(0; $1; "ExecuteFootRunner")
End if 