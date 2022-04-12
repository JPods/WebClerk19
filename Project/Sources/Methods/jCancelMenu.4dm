//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-05-25T00:00:00, 20:41:50
// ----------------------------------------------------
// Method: jCancelMenu
// Description
// Modified: 05/25/13
//  
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160405_0940

myCycle:=0
//
C_LONGINT:C283($tasks; $prsNum; $state; $tics)
$prsNum:=Current process:C322
PROCESS PROPERTIES:C336($prsNum; $curProcessName; $state; $tics)
KeyModifierCurrent
Case of 
	: ((cmdkey=1) & (OptKey=1))
		TRACE:C157
		FLUSH CACHE:C297
	: (OptKey=1)
		TRACE:C157
	: ((vHere=0) & ($curProcessName="Sales Dept"))
		//  ignor command and remain in
		//  MenuReset (1)
	Else 
		jCancelButton(True:C214)  //true support recovering any in use Counter Numbers
End case 
// 