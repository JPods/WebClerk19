//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/15/18, 10:40:48
// ----------------------------------------------------
// Method: IE_GetPict
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: IE_GetPict
C_LONGINT:C283($err)
C_PICTURE:C286($thePict)
C_TEXT:C284($1; $theDoc)
C_POINTER:C301($2; $ptPict)
OK:=1
Case of 
	: (Count parameters:C259=2)
		$theDoc:=$1
		$ptPict:=$2
		CLEAR VARIABLE:C89($ptPict->)
	: (Count parameters:C259=1)
		$theDoc:=$1
		$ptPict:=->[ItemSpec:31]pictureFld:3
	Else 
		OK:=0
End case 
If ($theDoc="")
	// opens dialog to get an image
	// consider replacing with drag and drop
	READ PICTURE FILE:C678(""; $thePict)
Else 
	//alert(PathToSystem(vImagePath))
	$theDoc:=PathToSystem($theDoc)
	$result:=Test path name:C476($theDoc)
	Case of 
		: ($result=1)
			READ PICTURE FILE:C678($theDoc; $thePict)
		: ($result=0)
			If (<>viDebugMode=411)
				ConsoleMessage("ERROR: Path is a folder")
			End if 
		Else 
			If (<>viDebugMode=411)
				ConsoleMessage("ERROR: "+String:C10($result)+"  FILE NOT FOUND\r"+$theDoc)
			End if 
	End case 
End if 
If (OK=1)
	$ptPict->:=$thePict
End if 