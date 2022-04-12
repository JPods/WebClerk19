//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 121106, 16:49:06
// ----------------------------------------------------
// Method: PrinterSelect
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $desiredPrinter; $0)
C_TEXT:C284($theCommand; $inputStream; $outputStream; $errorStream)
C_LONGINT:C283($p)
$0:=""  //send back an empty string if there is no change in the printer
If ($1#"")
	$desiredPrinter:=$1
	If (Is macOS:C1572)
		$theCommand:="lpstat -d"
		LAUNCH EXTERNAL PROCESS:C811($theCommand; $inputStream; $outputStream; $errorStream)
		$p:=Position:C15(": "; $outputStream)
		$outputStream:=Substring:C12($outputStream; $p+2)
		$p:=Position:C15("\n"; $outputStream)
		If ($p>0)
			$currentPrinter:=Substring:C12($outputStream; 1; $p-1)
		Else 
			$currentPrinter:=$outputStream
		End if 
	Else 
		$theCommand:="cscript C:\\windows\\system32\\prnmngr.vbs -g"
		LAUNCH EXTERNAL PROCESS:C811($theCommand; $inputStream; $outputStream; $errorStream)
		$findString:="The default printer is "
		$p:=Position:C15($findString; $outputStream)
		$outputStream:=Substring:C12($outputStream; $p+Length:C16($findString))
		$p:=Position:C15("\n"; $outputStream)
		If ($p>0)
			$currentPrinter:=Substring:C12($outputStream; 1; $p-1)
		Else 
			$currentPrinter:=$outputStream
		End if 
	End if 
	If ($desiredPrinter#$currentPrinter)
		ARRAY TEXT:C222($aPrinterList; 0)
		PRINTERS LIST:C789($aPrinterList)
		$w:=Find in array:C230($aPrinterList; $desiredPrinter)
		If ($w>0)
			If (Is macOS:C1572)
				$theCommand:="lpoptions -d "+$desiredPrinter
			Else 
				$theCommand:="Rundll32.EXE printui.dll,PrintUIEntry /y /q /n "+$desiredPrinter
				
				If (False:C215)
					//Get List Printer, verbose
					$theCommand:="cscript C:\\windows\\system32\\prnmngr.vbs -l"
					
					//Get List Printer, verbose
					$theCommand:="cscript C:\\windows\\system32\\prnmngr.vbs -t -p "+Txt_Quoted("\\Servername\\printername")
					$theCommand:="cscript C:\\windows\\system32\\prnmngr.vbs -t -p \"\\Servername\\printername\""
					
				End if 
			End if 
			C_TEXT:C284($inputStream; $outputStream; $errorStream)
			LAUNCH EXTERNAL PROCESS:C811($theCommand; $inputStream; $outputStream; $errorStream)
			SET CURRENT PRINTER:C787($desiredPrinter)
			$currentPrinter:=Replace string:C233($currentPrinter; " "; "_")
			$currentPrinter:=Replace string:C233($currentPrinter; "."; "_")
			$0:=$currentPrinter  //return the current printer so it can be restored as needed.
		End if 
	End if 
End if 