//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-09T00:00:00, 09:49:44
// ----------------------------------------------------
// Method: MD_LaunchWindow
// Description

// Modified by: William James (2013-06-09T00:00:00
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k; $found)
C_BOOLEAN:C305($doPrcWind)
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "Mtl_SignOut")
ptCurTable:=(->[Control:1])
jSetMenuNums(1; 5; 6)
Open window:C153(Screen width:C187-740; 40; Screen width:C187-4; 480; 8; "Material Draw"; "")
//jCenterWindow (404;270;1)
ProcessTableOpen(->[Control:1])
Wd_FillRay(0)