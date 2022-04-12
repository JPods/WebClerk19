//%attributes = {}
// Script Get Picture from Clipboard 20170203
// James W. Medlen
// this could be expanded to include other image types

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-02-03T00:00:00, 13:39:56
// ----------------------------------------------------
// Method: GetPasteBoardPicture
// Description
// Modified: 02/03/17
// 
// 
//
// Parameters
// ----------------------------------------------------
//  See   // Method: GetPasteBoardText


C_PICTURE:C286(vpicture)
C_TEXT:C284(vtDataType)

vtDataType:="PICT"

Case of 
		// data formatted as png
	: (Pasteboard data size:C400("public.png")>0)
		GET PICTURE FROM PASTEBOARD:C522(vpicture)
		SET PICTURE TO PASTEBOARD:C521(vpicture)
		vtDataType:="PNG"
		
		// data formatted as pdf
	: (Pasteboard data size:C400("com.adobe.pdf")>0)
		GET PICTURE FROM PASTEBOARD:C522(vpicture)
		SET PICTURE TO PASTEBOARD:C521(vpicture)
		vtDataType:="PDF"
		
		// data formatted as jpg
	: (Pasteboard data size:C400("public.jpg")>0)
		GET PICTURE FROM PASTEBOARD:C522(vpicture)
		SET PICTURE TO PASTEBOARD:C521(vpicture)
		vtDataType:="JPG"
		
	Else 
		
		GET PICTURE FROM PASTEBOARD:C522(vpicture)
		SET PICTURE TO PASTEBOARD:C521(vpicture)
		
End case 

ALERT:C41(vtDataType+" image copied to clipboard")
