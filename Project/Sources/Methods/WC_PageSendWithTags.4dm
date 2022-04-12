//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/03/10, 18:21:19
// ----------------------------------------------------
// Method: WC_PageSendWithTags
// Description
//
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $3; $p; $blobSize)
C_TEXT:C284($2; $documentPath)
C_BLOB:C604($blobPageOut)
SET BLOB SIZE:C606($blobPageOut; 0)

$documentPath:=Replace string:C233($2; "/"; Folder separator:K24:12)

// obEventLog
If ((vUseBase<2) | (vUseBase>5))  //for safety
	vUseBase:=2
End if 
C_LONGINT:C283($p; <>lenJitTag; <>lenMidTag; <>lenEndTag; $tableNum)
C_TEXT:C284($myText; $builtText; $text2Send; $actionText)
$myText:=""
$doRecord:=False:C215

// get the page from the correct web folder
$text2Send:=WC_PageLoad($documentPath; ->$documentPath)  // ### AZM ### 20180914 SEND POINTER SO THAT UPDATED DOCUMENT PATH CAN BE USED LATER

$text2Send:=Replace string:C233($text2Send; "jitRemote"; <>vWCPathRemoteViaWeb)

// ### jwm ### 20150922_1108 check security level
C_LONGINT:C283($jitSecure)
C_BOOLEAN:C305($doSecure)
C_TEXT:C284($content)

C_LONGINT:C283($jitSecure)  // check the page for access
C_BOOLEAN:C305($doSecure)
$jitSecure:=0
// ### bj ### 20181210_1514 call from Andy/Jim
$content:=WC_MetaTagRead($text2Send; "jitSecure"; 0)
$jitSecure:=Num:C11($content)

// ### jwm ### 20181210_1649 updated security check
If (($jitSecure>viSecureLvl) & ($jitSecure>vWccSecurity))
	vResponse:="Error: Security level required above current access"
	$documentPath:=<>WebFolder+"error.html"
	$text2Send:=WC_PageLoad($documentPath; ->$documentPath)  // ### AZM ### 20180914 SEND POINTER SO THAT UPDATED DOCUMENT PATH CAN BE USED LATER
End if 
C_LONGINT:C283($offset; $lenBlob)
C_LONGINT:C283($tableNum)

WC_VariablesRead

// ### bj ### 20181202_0838
// should we change this  ??
C_TEXT:C284($textFinal)
// jsonPage:="true"
Case of 
	: (jsonPage="t@")  // LEGACY TAG PROCESSING METHODS
		$textFinal:=$text2Send
	: (True:C214)  // LEGACY TAG PROCESSING METHODS
		$textFinal:=TagsToText($text2Send)  // Bill James
	: (False:C215)
		$textFinal:=TP_TagsToText($text2Send)  // Andy Mercer v1
	Else 
		$textFinal:=TP_TagsToText($text2Send)  // Andy Mercer v2
End case 

If (<>viDebugMode>410)
	ConsoleMessage("$textFinal: "+$textFinal)  // ### jwm ### 20171006_0941
	//SET TEXT TO PASTEBOARD($textFinal)
End if 

//$0:=WC_SendServerResponse ($textFinal;$documentPath)  // ### AZM ### 20180914 USE NEW SINGLE OUTPUT METHOD
$0:=WC_SendServerResponse($textFinal; WC_GetContentTypeFor(SuffixGet($documentPath)))  // ### AZM ### 20190520 Switch to sending Content Type directly.

SET BLOB SIZE:C606($blobPageOut; 0)
vbWccPriceLiteral:=0
