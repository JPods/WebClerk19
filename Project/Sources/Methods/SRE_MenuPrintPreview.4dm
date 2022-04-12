//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-26T00:00:00, 14:26:27
// ----------------------------------------------------
// Method: SRE_MenuPrintPreview
// Description
// Modified: 08/26/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $2; $srArea; $menuNumber)
C_TEXT:C284($reportXML)
C_LONGINT:C283($result; $newReportArea; $cbUseNewApi; $options; $debugAdders)



C_TEXT:C284($reportXML)
$result:=SR_SaveReport(eSRWin; $reportXML; 0)  // third arg means it is a report
$result:=SR_Print($reportXML; 0; SRP_Print_DestinationPreview+SRP_Print_NoProgress; ""; 0; "")




// $err:=SR Menu Item ($area; SR MenuItem Set 4D Method; SR MenuItem Print To Disk; ""; 0; 0; "SRE_MenuPrintPreview")