//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 01:17:22
// ----------------------------------------------------
// Method: Image_Process
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306($vhDocRef)
C_OBJECT:C1216($voParameters)
TRACE:C157
$vhDocRef:=Create document:C266("")  // Save the document of y
If (OK=1)
	CLOSE DOCUMENT:C267($vhDocRef)
	$voParameters:=New object:C1471("url"; Get text from pasteboard:C524; "path"; Document)
	$voParameters:=Image_Download($voParameters)
	If (OK=1)
		
	Else 
		
	End if 
End if 