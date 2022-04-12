//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_nds
	
	//06/10/2002.nds 
	//  Added init of default image compression quality
	//02/21/2002.nds 
	//  Add this routine to startup code and call any pref inits here
	TCStrong_prf_v152
	//03/31/03.prf
	//added new default prefs
	//  TCStrong_dmb_v400
	//10/27/04.dmb
	//Removed public ip address.
End if 

PrefsPut("QPixCompQuality"; "Low")  //06/10/2002.nds 

//10/27/04.dmb - public ip no longer used.
//03/31/03.prf BEGIN
//If (Current user="Arkware")
//PrefsPut ("FaxServerIPAddress";"63.120.40.34")//address for development
//Else 
PrefsPut("FaxServerIPAddress"; "192.168.1.12")
//End if 
PrefsPut("FaxServerPort"; "8008")
PrefsPut("PDFName"; "Printer")
PrefsPut("PDFDriver"; "Acrobat PDFWriter")
//03/31/03.prf END

//PrefsPut ("NewRecords";"Many")// Add one or many records at a time.
//PrefsPut ("ShowNavPlttAtStartup";"True")// Display the Navigation Palette at 
//startup?

