//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/10/11, 01:01:54
// ----------------------------------------------------
// Method: Ed_ScrptOpenWin
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Modified by: williamjames (110111)// elimitated the check for 4D Write
//

//jAlertMessage (19001)
//C_Longint($test)
//If ($test=1)
Process_InitLocal
ptCurTable:=(->[Control:1])

C_LONGINT:C283($i)
C_POINTER:C301($ptVar)
<>prcControl:=0

// ### bj ### 20181204_1542 uncompiled declaration error
ARRAY TEXT:C222(aiLoText16; 0)
ARRAY TEXT:C222(aiLoText15; 0)
C_OBJECT:C1216($obWindows)
$obWindows:=WindowCountToShow
$form_t:="SummaryText"
$win_l:=Open form window:C675([Control:1]; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
//Open window(10; 60; 880; 740; 8; "Script Editor"; "jCancelButton")
ptCurTable:=(->[Control:1])
DIALOG:C40([Control:1]; "SummaryText")
vi4DWriteUser:=-1
//End if 
POST OUTSIDE CALL:C329(<>theProcessList)
