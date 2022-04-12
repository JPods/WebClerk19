//%attributes = {"publishedWeb":true}
// Script Get Text From Clipboard 20170227

C_BLOB:C604(vxdata)
C_TEXT:C284(vtext; vtDataType)
vText:=""
vtDataType:="Text"

Case of 
		
		// Excel 2016 data formatted as text
	: (Pasteboard data size:C400("public.utf8-plain-text")>0)
		GET PASTEBOARD DATA:C401("public.utf8-plain-text"; vxdata)
		vText:=BLOB to text:C555(vxdata; UTF8 text without length:K22:17)
		SET TEXT TO PASTEBOARD:C523(vText)
		vtDataType:="UTF8"
		
		// 4D default text format
	: (Pasteboard data size:C400("public.utf16-plain-text")>0)
		vText:=Get text from pasteboard:C524
		vtDataType:="UTF16"
		
		// data formatted as html
	: (Pasteboard data size:C400("public.html")>0)
		GET PASTEBOARD DATA:C401("public.html"; vxdata)
		vText:=BLOB to text:C555(vxdata; UTF8 text without length:K22:17)
		SET TEXT TO PASTEBOARD:C523(vText)
		vtDataType:="HTML"
		
		// data formatted as rtf
	: (Pasteboard data size:C400("public.rtf")>0)
		GET PASTEBOARD DATA:C401("public.rtf"; vxdata)
		vtDataType:="RTF"
		
	Else 
		
		vText:=Get text from pasteboard:C524
		
End case 

ALERT:C41(vtDataType+" text copied to clipboard")


// Script Get Picture from Clipboard 20170203

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


ARRAY TEXT:C222(4Dsignatures; 0)
ARRAY TEXT:C222(nativeTypes; 0)
ARRAY TEXT:C222(formatNames; 0)

vText:=""

GET PASTEBOARD DATA TYPE:C958(4Dsignatures; nativeTypes; formatNames)

For (vi1; 1; Size of array:C274(4Dsignatures))
	
	vText:=vText+4Dsignatures{vi1}+"\t"+nativeTypes{vi1}+"\t"+nativeTypes{vi1}+"\r"
	
End for 

SET TEXT TO PASTEBOARD:C523(vText)

ALERT:C41("Copied to ClipBoard\r\r"+vtext)