//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/28/17, 11:52:25
// ----------------------------------------------------
// Method: jSORT
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($offsetHor; $offsetVert)
$offsetHor:=120
$offsetVert:=60
Open window:C153(5+$offsetHor; 40+$offsetVert; 460+$offsetHor; 550+$offsetVert; 5; "Sort"; "Wind_CloseBox")
DIALOG:C40([Admin:1]; "DiaSort")
CLOSE WINDOW:C154
//MenuBarByLevel 
