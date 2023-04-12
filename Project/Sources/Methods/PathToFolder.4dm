//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/30/18, 11:08:00
// ----------------------------------------------------
// Method: PathToFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($path)
C_POINTER:C301($1; $ptText)
$path:=Select folder:C670("Select the desired folder"; "")
If (OK=1)
	If (Count parameters:C259=0)
		SET TEXT TO PASTEBOARD:C523($path)
		ConsoleLog($path)
		ALERT:C41("Path is on Clipboard and Console")
	Else 
		$1->:=$1->+("\r"*2*(Num:C11($1->#"")))+$path
	End if 
End if 