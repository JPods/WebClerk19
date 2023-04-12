//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:39:35
// ----------------------------------------------------
// Method: japplyCurSelect
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Import"))
	
	jCenterWindow(645; 520; -724; "Apply To Selection"; "Wind_CloseBox")
	DIALOG:C40([Admin:1]; "diaApply2SelRec")
	CLOSE WINDOW:C154
	ReadOnlyFiles
	jaFilesClose
	MenuBarByLevel
End if 