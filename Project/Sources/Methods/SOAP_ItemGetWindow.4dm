//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/12/09, 14:12:19
// ----------------------------------------------------
// Method: SOAP_ItemGetWindow
// Description
// 
//
// Parameters
// ----------------------------------------------------

//
Process_InitLocal

srItemMfgItemNum:="100036"
srItemMfgID:="dagger"
srUserName:="terra"
srPassword:="jit"
<>vSoapTrack:=2
//OPEN WINDOW(4;40;424;218;-724;"Export General";"Wind_CloseBox")
jCenterWindow(460; 214; 3; "Get Item"; "Wind_CloseBox")
DIALOG:C40([Item:4]; "GetItem")
CLOSE WINDOW:C154