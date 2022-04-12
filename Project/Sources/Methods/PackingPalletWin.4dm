//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/04/15, 14:04:49
// ----------------------------------------------------
// Method: PackingPalletWin
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	version_67_200506
End if 
<>prcControl:=0

Process_InitLocal
ptCurTable:=(->[Control:1])
//
ControlRecCheck
//TRACE
Case of 
	: (Screen width:C187=1680)
		// ### jwm ### 20150722_1336
		//Open window((Screen width-550-480);40;(Screen width-2-460);590+60;8;"Processes";"Wind_CloseBox")  //###_jwm_wide screen ###
		Open window:C153(10; 40; 1020; 840; 8; "Processes"; "Wind_CloseBox")  //###_jwm_wide screen ###
		
	Else 
		// ### jwm ### 20150722_1337
		//Open window(Screen width-550-84;40;Screen width-2-80;590+40;8;"Processes";"Wind_CloseBox")
		Open window:C153(10; 40; 1020; 840; 8; "Processes"; "Wind_CloseBox")
End case 
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "PackingPallets")
ProcessTableOpen(->[Control:1])
CLEAR VARIABLE:C89(pagePict1)

//Open window (left; top; right; bottom{; type{; title{; controlMenuBox}}}){ WinRef }