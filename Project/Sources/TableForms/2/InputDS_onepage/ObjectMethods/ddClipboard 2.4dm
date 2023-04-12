
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/08/17, 10:46:19
// ----------------------------------------------------
// Method: entryEntity..Input1.ddClipboard
// Description
// Dropdown menu for Clipboard Icon
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($vtOption)

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(atClipboard; 0)
		APPEND TO ARRAY:C911(atClipboard; "Clipboard")
		APPEND TO ARRAY:C911(atClipboard; "Combine Previous")
		APPEND TO ARRAY:C911(atClipboard; "Combine Next")
		APPEND TO ARRAY:C911(atClipboard; "Import Address")
		APPEND TO ARRAY:C911(atClipboard; "Export Address")
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$vtOption:=atClipboard{atClipboard}  //set option selected
		
		Case of 
			: ($vtOption="Combine Previous")
				
				CONFIRM:C162("Combine Previous Customer Into Current?"; " Combine "; " Cancel ")
				If (OK=1)
					Dup_CustDetail(1; 0; 0)  //pull info from previous record into this record
				End if 
				
			: ($vtOption="Combine Next")
				
				CONFIRM:C162("Combine Next Customer Into Current?"; " Combine "; " Cancel ")
				If (OK=1)
					Dup_CustDetail(0; 0; 0)  //pull info from next record into this record
				End if 
				
			: ($vtOption="Import Address")
				
				CONFIRM:C162("Import Address From Clipboard?"; " Import "; " Cancel ")
				If (OK=1)
					CB_GetText  // get Address from clipboard
				End if 
				
			: ($vtOption="Export Address")
				
				CONFIRM:C162("Export Address To Clipboard?"; " Export "; " Cancel ")
				If (OK=1)
					CB_PostAddress  // post address to clipboard
				End if 
				
		End case 
	: (Form event code:C388=On Data Change:K2:15)
		// no action
End case 

atClipboard:=1  // reset to top of list
