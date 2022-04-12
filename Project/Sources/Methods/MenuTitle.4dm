//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-11-21T00:00:00, 04:06:52
// ----------------------------------------------------
// Method: MenuTitle
// Description
// Modified: 11/21/15
// Structure: CEv13_131005
//
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20180330_1251 added parameter to pass additional window title

var $1; $vWindowTitle : Text

If (Count parameters:C259>=1)
	$vWindowTitle:=$1
End if 

Case of 
	: (ptCurTable=(->[Control:1]))
		// do nothing. Must be done in the various windows.
	: (vHere=0)
		// implement
	: (vHere=1)  // in oLo
		If ($vWindowTitle#"")
			$vWindowTitle:=" - "+$vWindowTitle
		End if 
		SET WINDOW TITLE:C213(Table name:C256(ptCurTable)+":  "+String:C10(Records in selection:C76(ptCurTable->))+" - "+Storage:C1525.default.company+$vWindowTitle)
	Else 
		// implement
End case 
