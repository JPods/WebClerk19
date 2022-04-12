//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:21:19
// ----------------------------------------------------
// Method: MarginShow
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Costing"))
	
	
	// MustFixQQQZZZ: Bill James (2021-12-10T06:00:00Z)
	// allow subselections to total and to change price and cost to change the main document
	// switch to collections
	
	var $obWindows : Object
	$obWindows:=WindowCountToShow
	$win_l:=Open form window:C675([Control:1]; "diaMargins"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	DIALOG:C40([Control:1]; "diaMargins")
	CLOSE WINDOW:C154
	vR1:=0
	vR2:=0
	vR3:=0
	vR4:=0
	v20Str1:=""
End if 