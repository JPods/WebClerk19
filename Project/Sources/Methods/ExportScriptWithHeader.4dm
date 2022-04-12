//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-22T00:00:00, 10:58:18
// ----------------------------------------------------
// Method: ExportScriptWithHeader
// Description
// Modified: 09/22/16
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160929_1326 no header if empty string


C_TEXT:C284($1; $theFolder; $2; $fileName; $3; $header; $4; $script)
C_TIME:C306($myDoc)
$theFolder:=$1
$fileName:=$2
$header:=$3
$script:=$4

$myDoc:=Create document:C266($theFolder+$fileName)
If (OK=1)
	If ($3#"")  // ### jwm ### 20160929_1326 no header if empty string
		$pCR:=Position:C15("\r"; $script)
		If ($pCR>0)
			$firstLine:=Substring:C12($script; 1; $pCR-1)
			If (Position:C15($header; $firstLine)#0)
				// name in first line
				$script:="  // "+$header+"\r"+$script
			End if 
		Else 
			$script:="  // "+$header+"\r"+$script
		End if 
	End if 
	SEND PACKET:C103($myDoc; $script)
	CLOSE DOCUMENT:C267($myDoc)
End if 