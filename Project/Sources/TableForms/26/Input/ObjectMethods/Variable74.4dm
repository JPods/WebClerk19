// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 14:12:42
// ----------------------------------------------------
// Method: Object Method: bBarCode
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(bBarCode)
Open window:C153(19; 165; 19; 165; 1)  //(19;165;119;185;1)
DIALOG:C40([DefaultQQQ:15]; "diaBarCode")
CLOSE WINDOW:C154
ConsoleMessage(vsBarCdFld)
//zzz ??? Need to turn this optionally on.  Functional Devices this is a problem.
//BarC_listItmsFl //###_jwm_### disabled due to shipping process 20100408