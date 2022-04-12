//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-01T00:00:00, 21:26:30
// ----------------------------------------------------
// Method: WC_CertKeyCheck
// Description
// Modified: 09/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($0; $certOK; $keyOK; $storeCertKey)
$storeCertKey:=0
<>tcCertificateFile:=""
<>tcPrivateKeyFile:=""
<>tcPrivateKeyPass:=""
$0:=0
C_LONGINT:C283($viTestCert; $viTestKey)
C_TEXT:C284($vtPathReport)
If ([WebClerk:78]pathToCert:21="")
	ConsoleMessage("Cert: Path is empty")
Else 
	$viTestCert:=Test path name:C476([WebClerk:78]pathToCert:21)
	If ($viTestCert=1)
		$vtPathReport:="Valid path"
	Else 
		$vtPathReport:="Failed path"
	End if 
	ConsoleMessage("Cert: "+[WebClerk:78]pathToCert:21+", Status: "+$vtPathReport)
End if 
If ([WebClerk:78]pathToKey:22="")
	ConsoleMessage("Key: Path is empty")
Else 
	$viTestCert:=Test path name:C476([WebClerk:78]pathToCert:21)
	If ($viTestCert=1)
		$vtPathReport:="Valid path"
	Else 
		$vtPathReport:="Failed path"
	End if 
	ConsoleMessage("Key: "+[WebClerk:78]pathToKey:22+", Status: "+$vtPathReport)
End if 

If (($viTestCert=1) & (Test path name:C476([WebClerk:78]pathToKey:22)=1))
	$0:=1
Else 
	If (([WebClerk:78]cert:10#"") & ([WebClerk:78]key:11#""))
		$myText:=Request:C163("Save cert to : "+[WebClerk:78]pathToCert:21; [WebClerk:78]pathToCert:21)
		If ($myText#"")
			[WebClerk:78]pathToCert:21:=$myText
			TEXT TO BLOB:C554([WebClerk:78]cert:10; $blobWorking; UTF8 text without length:K22:17)
			BLOB TO DOCUMENT:C526([WebClerk:78]pathToCert:21; $blobWorking)
			If (OK=1)
				[WebClerk:78]pathToCert:21:=document
				C_TEXT:C284($folder; $name)
				$folder:=HFS_ParentName([WebClerk:78]pathToCert:21)
				$name:=Tx_ClipFromBackToLastDelim([WebClerk:78]pathToCert:21; Folder separator:K24:12)
				[WebClerk:78]pathToKey:22:=$folder+$name+".key"
				TEXT TO BLOB:C554([WebClerk:78]key:11; $blobWorking; UTF8 text without length:K22:17)
				BLOB TO DOCUMENT:C526([WebClerk:78]pathToKey:22; $blobWorking)
				If (OK=1)
					$0:=1
				End if 
			End if 
		End if 
	End if 
End if 
