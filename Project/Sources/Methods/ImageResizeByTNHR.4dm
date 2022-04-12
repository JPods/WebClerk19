//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/07/20, 21:03:50
// ----------------------------------------------------
// Method: ImageResizeByTNHR
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_PICTURE:C286($mypicture)
C_TIME:C306($myImg)

C_TEXT:C284($2; $3; $vtPath; $vtPathTN; $vtPathHR)
C_LONGINT:C283($4; $viWidth)
C_POINTER:C301($1; $ptPicture)
If (Count parameters:C259>2)
	$vtPath:=$3
	OK:=1
Else 
	$vtPath:=Select folder:C670("Select folder of images to resize"; "")
End if 
If (OK=1)
	If (Count parameters:C259>3)
		$viWidth:=$4
	Else 
		$viWidth:=720
	End if 
	
	$ptPicture:=$1
End if 