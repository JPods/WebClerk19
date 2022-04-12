//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/13/09, 15:16:24
// ----------------------------------------------------
// Method: SoapProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------

//
XMLArrayManagement(0)
C_TEXT:C284($1; $2; $doc; $crlf; $machine; $m; $theText; $temp; $theText; $preExecute)
C_LONGINT:C283($stream; $stream; $stream)
$doSoap:=True:C214

If (Count parameters:C259>1)  //new process
	$doSoap:=True:C214
	$theURL:=$1  //"http://172.26.85.74/CreditCardWeb/servlet/rpcrouter"
	$theMessage:=$2  //[TallyMaster]ScriptCode
	If (Count parameters:C259>2)
		$theAdder:=$3
	End if 
Else 
	$doSoap:=False:C215
End if 

If (($doSoap) & ($theURL#""))
	ON ERR CALL:C155("jOECNoAction")
	//
	//$theURL:="http://172.26.85.74/taxApplicationWeb/servlet/rpcrouter"//$1
// zzzqqq URL_Cleanup zzzqqq 	//$theURL:=URL_Cleanup ($theURL)  //should already be a complete URL
	
	NTK_SetURL($theURL)  //this is a good procedure for parsing a complete URL.  Set each variable here.
	//HTTP_TimeOut:=10//seconds
	//HTTP_Protocol:="https"//process as SSL
	//HTTP_Path:=<>tcCCVerURL//Server command
	//HTTP_Host:=<>tcCCVerHost//Server manchine
	//HTTP_Port:=<>tcCCVerPort//the Port
	C_BLOB:C604(HTTP_IncomingBlob)
	$error:=WC_Request("POST")
	$theText:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
	//      
	Case of 
		: ($theText="")
			
		: (<>vSoapTrack=1)
			SET TEXT TO PASTEBOARD:C523($theText)
		: (<>vSoapTrack=2)
			SET TEXT TO PASTEBOARD:C523($theText)
			Repeat 
				XMLEditor
				C_LONGINT:C283($found)
				$found:=Prs_CheckRunnin("XML Editor")
				If ($found<1)
					DELAY PROCESS:C323(Current process:C322; 30)
				End if 
			Until ($found>0)
			POST OUTSIDE CALL:C329(<>aPrsNum{$found})
		: (<>vSoapTrack=3)
			$theText:=Replace string:C233($theText; Storage:C1525.char.crlf; "\r")
			$theText:=Replace string:C233($theText; Char:C90(10); "\r")
			EventLogsMessage(UtilFillMarkerLine("Raw Return")+$theText)
	End case 
	XMLParseTags($theText)
End if 
