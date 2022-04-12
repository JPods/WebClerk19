//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-16T00:00:00, 18:48:43
// ----------------------------------------------------
// Method: SRE_PrinterSend
// Description
// Modified: 07/16/13
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284(reportXML)
C_LONGINT:C283($result; $newReportArea; $cbUseNewApi; $options; $debugAdders)




//  +SRP_Print_NoProgress is for debugging, should be setup in the printer options
$debugAdders:=0
// set to zero on when not debugging
// if (false)    //  ?????
$debugAdders:=SRP_Print_NoProgress
// end if


$result:=SR_Print(reportXML)

If (False:C215)
	
	Case of 
		: ([UserReport:46]Destination:11=1)  //print
			$options:=0
			// SR_SetTextProperty (reportXML;SRP_Report_CountPages;1)
			// SR_GetPtrProperty (reportXML;;SRP_Report_CountPages;->vPageCount)
			
			$result:=SR_Print(reportXML; 0; SRP_Print_DestinationPrinter+$debugAdders; ""; 0; "")
			//  $result:=SR_Print (reportXML;0;SRP_Print_DestinationPrinter+$debugAdders;"";0;Get current printer)
			
		: ([UserReport:46]Destination:11=2)  //preview
			
			$result:=SR_Print(reportXML; 0; SRP_Print_DestinationPreview+$debugAdders; ""; 0; "")
			
		: ([UserReport:46]Destination:11=3)  //print to disk   
			
			$result:=SR_Print(reportXML; 0; SRP_Print_DestinationFile+$debugAdders; ""; 0; "")
			
		: ([UserReport:46]Destination:11=4)  //print to PDF   
			
			$result:=SR_Print(reportXML; 0; SRP_Print_DestinationPDF+$debugAdders; ""; 0; "")
			
		: ([UserReport:46]Destination:11=6)  // ask with pdf  
			
			$result:=SR_Print(reportXML; 0; SRP_Print_AskJobSetup+SRP_Print_DestinationPDF; ""; 0; "")
			
		Else   //: ([UserReport]Destination=5)  //print to ask  
			
			$result:=SR_Print(reportXML; 0; SRP_Print_AskJobSetup+$debugAdders; ""; 0; "")
			
	End case 
	
	vDoc:=""
End if 

