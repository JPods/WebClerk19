//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/05/09, 11:08:26
// ----------------------------------------------------
// Method: B2BSyncRequest
// Description
// 
//
// Parameters
// ----------------------------------------------------

//
C_TEXT:C284($password; $userName; $1; $4; $5; $vRequest)
C_TEXT:C284($doc; $machine; $m; $theText; $temp; $theText)
C_TEXT:C284(WC_SiteInsert)
C_BOOLEAN:C305($doParameters)
C_LONGINT:C283($ipStream; $s; $err; $thePort; $2; $vLen)
//ON ERR CALL("jOECNoAction")
$doParameters:=(Count parameters:C259=2)
vText1:=""
TRACE:C157
C_BLOB:C604(vUpLoadBlob)
C_BLOB:C604($incomingBlob)
C_LONGINT:C283($offSet)
C_TEXT:C284($testText)
SET BLOB SIZE:C606(vUpLoadBlob; 0)
vResponse:="Action not completed"



$machine:=$1
$thePort:=$2
$command:=$3
$ipStream:=0
//$doc:=Substring($command;Position("//";$command)+2)
If ($command#"/@")
	$command:="/"+$command
End if 
//
$vRequest:=$vRequest+"GET "+$command+" HTTP/1.1"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"Host: "+$machine+Storage:C1525.char.crlf
$vRequest:=$vRequest+"Accept: */*"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"Connection: Keep-Alive"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"ACCEPT-Language: en-us"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"User-Agent: WebClerk"+Storage:C1525.char.crlf  //Mozilla/4(compatible;MSIE 5.5;Windows 98)
$vRequest:=$vRequest+Storage:C1525.char.crlf  //second CRLF





$testText:=BLOB to text:C555($incomingBlob; UTF8 text without length:K22:17; $offSet; 400)
If ($testText="Error@")
	ALERT:C41($testText)
Else 
	C_LONGINT:C283($cntEffort; $cntUpdate)
	sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitF+"jitSync"+String:C10(DateTime_Enter)+".txt")
	CLOSE DOCUMENT:C267(sumDoc)
	BLOB TO DOCUMENT:C526(document; vUpLoadBlob)
	Sync_OpenIn(document)
End if 

