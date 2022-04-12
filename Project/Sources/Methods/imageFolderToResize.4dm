//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/07/20, 21:14:38
// ----------------------------------------------------
// Method: imageFolderToResize
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($2; $viWidth)
If (Count parameters:C259>0)
	$vtPath:=$1
	OK:=1
Else 
	$vtPath:=Select folder:C670("Select folder of images to resize"; "")
End if 
If (OK=1)
	If (Count parameters:C259>1)
		$viWidth:=$2
	Else 
		$viWidth:=720
	End if 
	ARRAY TEXT:C222($aDocumentPaths; 0)
	DOCUMENT LIST:C474($vtPath; $aDocumentPaths; Absolute path:K24:14)
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274($aDocumentPaths)
	For ($i; 1; $k)
		
	End for 
End if 