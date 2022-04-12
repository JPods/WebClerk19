//%attributes = {}
// Script Get Text From Clipboard 20170203
// James W. Medlen
// this could be expanded to include other options

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-02-03T00:00:00, 13:39:39
// ----------------------------------------------------
// Method: GetPasteBoardText
// Description
// Modified: 02/03/17
// 
// 
//
// Parameters
// ----------------------------------------------------

//  See GetPasteBoardPicture

C_BLOB:C604($vxdata)
C_TEXT:C284($text; vtDataType)
$text:=""
C_TEXT:C284($1)
If (Count parameters:C259=1)
	vtDataType:=$1
Else 
	vtDataType:="Text"
End if 

Case of 
	: ((vtDataType="Text") | (vtDataType="utf@"))
		GET PASTEBOARD DATA:C401("public.utf8-plain-text"; $vxdata)
		$text:=BLOB to text:C555($vxdata; UTF8 text without length:K22:17)
		
		// vtDataType:="UTF8"
		
		// data formatted as rtf
	: (vtDataType="rtf")  //(Pasteboard data size("public.rtf")>0)
		GET PASTEBOARD DATA:C401("public.rtf"; $vxdata)
		$text:=BLOB to text:C555($vxdata; UTF8 text without length:K22:17)
		vtDataType:="RTF"
		
		// Excel 2016 data formatted as text
	: (vtDataType="utf8")  // (Pasteboard data size("public.utf8-plain-text")>0)  not used part of first case
		GET PASTEBOARD DATA:C401("public.utf8-plain-text"; $vxdata)
		$text:=BLOB to text:C555($vxdata; UTF8 text without length:K22:17)
		//SET TEXT TO PASTEBOARD($text)
		
		
		// 4D default text format // not used, part of first case
	: (Pasteboard data size:C400("public.utf16-plain-text")>0)
		$text:=Get text from pasteboard:C524
		vtDataType:="UTF16"
		
		// data formatted as html
	: (vtDataType="html")  //  Pasteboard data size("public.html")>0)
		GET PASTEBOARD DATA:C401("public.html"; $vxdata)
		$text:=BLOB to text:C555($vxdata; UTF8 text without length:K22:17)
		// SET TEXT TO PASTEBOARD($text)
		vtDataType:="HTML"
		
	Else 
		// not used part of first case
		$text:=Get text from pasteboard:C524
		
End case 
$0:=$text

// ALERT(vtDataType+" text copied to clipboard")
