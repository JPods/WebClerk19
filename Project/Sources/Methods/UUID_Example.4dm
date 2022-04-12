//%attributes = {}

// ----------------------------------------------------
// User name (OS): J.Medlen Fix
// Date and time: 2016-10-10T00:00:00, 16:24:19
// ----------------------------------------------------
// Method: FixPrimaryKeyRepair
// Description
// Modified: 10/10/16
// 
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	ALL RECORDS:C47([QQQContact:13])
	APPLY TO SELECTION:C70([QQQContact:13]; [QQQContact:13]id:62:=Generate UUID:C1066)
	
	ALL RECORDS:C47([OrderLine:49])
	APPLY TO SELECTION:C70([OrderLine:49]; [OrderLine:49]id:70:=Generate UUID:C1066)
	
	UNLOAD RECORD:C212([QQQContact:13])
	SET INDEX:C344([QQQContact:13]id:62; False:C215)
	SET INDEX:C344([QQQContact:13]id:62; True:C214)
	
	UNLOAD RECORD:C212([OrderLine:49])
	SET INDEX:C344([OrderLine:49]id:70; False:C215)
	SET INDEX:C344([OrderLine:49]id:70; True:C214)
End if 