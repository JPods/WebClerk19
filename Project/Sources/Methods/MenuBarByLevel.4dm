//%attributes = {}
// ----------------------------------------------------
// User name (OS): root
// Date and time: 04/25/07, 19:41:23
// ----------------------------------------------------
// Method: MenuBarByLevel
// Description
// 
//
// Parameters
// ----------------------------------------------------
Case of 
	: (vHere=0)
		SET MENU BAR:C67(splashMenu)
	: (vHere=1)
		SET MENU BAR:C67(oLoMenu)
	Else 
		SET MENU BAR:C67(iLoMenu)
End case 