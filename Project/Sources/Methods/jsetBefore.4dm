//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/17/17, 12:01:37
// ----------------------------------------------------
// Method: jsetBefore
// Description
//
//
// Parameters
// ----------------------------------------------------


// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
// Remove this from all DS layouts

var $1 : Variant
var $2 : Boolean
var $tableName : Text
MESSAGES OFF:C175
iLoQAText1:=""
allowAlerts_boo:=True:C214
booPreNext:=False:C215
$tableName:=process_o.dataClassName
iLoPagePopUpMenuBar($tableName)  // This should be reviewed for removal

If (process_o.saveOK#Null:C1517)
	If (process_o.saveOK="viewOnly")
		SET MENU BAR:C67(iLoMenu)
		
		MESSAGES OFF:C175
		iLoQAText1:=""
		allowAlerts_boo:=True:C214
		booPreNext:=False:C215
		
		booDuringDo:=True:C214  //use to avoid all during phase actions when side buttons are used.
		
		jSetAutoReMenus
		
		
		jSetAutoReMenus
		doItemList:=True:C214
		
		
		iLoPagePopUpMenuBar($1)
		aPages:=1
		SET MENU BAR:C67(iLoMenu)  //;$viProcess;*)
	End if 
End if 
