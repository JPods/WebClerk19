
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/20/17, 15:34:36
// ----------------------------------------------------
// Method: entryEntity..Input1.Variable89
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171120_1534  added button for DateLastUpdated

CONFIRM:C162("Set Date Last Updated."; " Set "; " Cancel ")
If (OK=1)
	[QQQCustomer:2]dateLastUpdated:107:=Current date:C33
End if 
