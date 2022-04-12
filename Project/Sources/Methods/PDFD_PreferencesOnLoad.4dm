//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:      PDFD_PreferencesOnLoad
	//Desc.:  Sets up PDF page for Preferences dialog
	//NB:      
	//CB:      [Constant];"Preferences" On Load Event
	//New:    04/17/2002 Noah Swiler 
	// TCStrong_prf_v142_PDF
	//  TCStrong_prf_v142
	//01/31/03.prf
	//temporarily commented out PDF plugin code
	//  TCStrong_prf_v148
	//03/19/03.prf
	//restore PDF plugin code
	TCStrong_nds
	//06/05/2002.nds 
	//  Copied from Sheba & customized to work with tC
	//SPS
	//SPS_nds
	//TCStrong_prf_v302
	//01/29/04.prf 
	//Removed PDFDirect for OSX users
End if 

C_LONGINT:C283($Error_l)
//TRACE
//03/19/03.prf
//01/31/03.prf
If (Is macOS:C1572)  //01/29/04.prf 
	//We're showing current printer info on loading
	ShowPrinterInfo_rb1:=1
	ShowPrinterInfo_rb2:=0
	OBJECT SET VISIBLE:C603(PDFAssign_lbtn; True:C214)  //only allow saving of current printer preference
	
Else 
	
	//$Error_l:=PD_GetPrinter(PDFCurrentName_s;PDFCurrentType_s;PDFCurrentZone
	//_s;PDFCurrentDriver_s)
	
	If ($Error_l#0)
		ALERT:C41("Error "+String:C10($Error_l)+" occurred while attempting to determine current print settings. Please contact "+"database designer.")
		//Alert2("Error "+String($Error_l)+" occurred while attempting to determine 
		//current print settings. Please contact "+"database designer.")
		
	End if 
	
End if 


//End of routine