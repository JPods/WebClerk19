//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/05/21, 15:26:22
// ----------------------------------------------------
// Method: En_GetImage
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1; $path : Text
var $2; $ptPict : Pointer
$path:=$1
$ptPict:=$2
var $w : Integer
CLEAR VARIABLE:C89($ptPict->)
$path:=PathToSystem($path)
ConsoleLog("pathFinal: "+$path)
$result:=Test path name:C476($path)
Case of 
	: ($result=1)
		READ PICTURE FILE:C678($path; $ptPict->)
	: ($result=0)
		BEEP:C151
		ConsoleLog("ERROR: Path is a folder")
	Else 
		ConsoleLog("ERROR: "+String:C10($result)+"  FILE NOT FOUND\r"+$path)
		BEEP:C151
		$w:=Position:C15("CommerceExpert"; $path)
		If ($w>0)
			$pathServer:=Storage:C1525.paths.serverComEx+Substring:C12($path; $w+15)
			If ((Test path name:C476($pathServer)=1) & ($pathServer#""))
				READ PICTURE FILE:C678($pathServer; $ptPict->)
				ConsoleLog("ERROR: "+String:C10($result)+"  FILE Server FOUND\r"+$path)
			Else 
				$pathLocal:=Storage:C1525.paths.localComEx+Substring:C12($path; $w+15)
				If (Test path name:C476($path)=1)
					READ PICTURE FILE:C678($pathLocal; $ptPict->)
					ConsoleLog("ERROR: "+String:C10($result)+"  FILE local FOUND\r"+$path)
				End if 
			End if 
		End if 
End case 