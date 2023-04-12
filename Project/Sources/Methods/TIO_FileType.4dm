//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/23/17, 17:17:22
// ----------------------------------------------------
// Method: TIO_FileType
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)  //pointer to Text: Path to TextIn File to Parse
C_LONGINT:C283($viFound)  // position of line ending
C_TIME:C306($vhDocRef)  // document reference
C_BLOB:C604($vxBlob)  // blob to conver text
C_TEXT:C284($vtFileType; $text; $0)  // file type, converted text

// ### jwm ### 20170323_1623 begin test here
// default type set to match OS
If (Is macOS:C1572)
	$vtFileType:="Mac"
Else 
	$vtFileType:="Windows"
End if 
// check file for line endings
$vhDocRef:=Open document:C264($1->; Read mode:K24:5)  // open document read only
//$vhDocRef:=Open document("")  // open document
If (OK=1)  // If a document has been chosen
	CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
	DOCUMENT TO BLOB:C525(Document; $vxBlob)  // Load the document
	$text:=BLOB to text:C555($vxBlob; UTF8 text without length:K22:17)
	$viFound:=0
	$viFound:=Position:C15(Storage:C1525.char.crlf; $text)
	If ($viFound>0)
		$vtFileType:="Windows"
	Else 
		$viFound:=Position:C15("\r"; $text)
		If ($viFound>0)
			$vtFileType:="Mac"
		Else 
			$viFound:=Position:C15("\n"; $text)
			If ($viFound>0)
				$vtFileType:="Unix"
			End if 
		End if 
	End if 
	If (<>viDebugMode>=3)
		ConsoleLog("File Type = "+$vtFileType+" - "+Document)
	End if 
End if 
// ### jwm ### 20170323_1623 end test here
$0:=$vtFileType
