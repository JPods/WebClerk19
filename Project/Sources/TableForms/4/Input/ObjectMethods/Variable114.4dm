// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 09/14/09, 15:15:46
// ----------------------------------------------------
// Method: Object Method: b42
// Description
// Items BOM Export Button
// Form:  [Item]iItems_9
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150514_1048 updated for Mac and PC

C_TEXT:C284($path)
C_LONGINT:C283($result)

KeyModifierCurrent
If (optKey=1)
	Bom_Export(Num:C11(optKey=0))
Else 
	
	If (Is macOS:C1572)
		$path:="FDI:BOMs:"
	Else 
		$path:="\\\\FDI-NAS\\FDI\\BOMs\\"
	End if 
	
	$result:=(Test path name:C476($path))
	
	If ($result<0)
		ALERT:C41("ERROR: Path Not Found "+$path+"\r\r Please Log in to the FDI File Server")
	Else 
		//check Extended BOM
		bExtendedBOM:=1
		BOM_DoBOM
		BOM_CostMatrix
		BOM_Export_fdi
	End if 
	
End if 