//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/18/18, 01:04:37
// ----------------------------------------------------
// Method: TNCaptureWebArea
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($webPageText; $0)
WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "getContent"; $webPageText)
// tinyMCE_cleanCR($webPageText))  // fills with \n 

///Users/williamjames/CommerceExpert/jitWeb/jitHelp/technotes/Chap_029/images/Exchange.png
//Beldin:Users:williamjames:CommerceExpert:jitWeb:jitHelp:technotes:Chap_029:images:

$webPageText:=Tx_ReplaceURLstrings($webPageText; "src=\""; "\""; "nofile"; "")

//  SET TEXT TO PASTEBOARD($webPageText)

//   $webPageText:=Replace string($webPageText;"\\n";"\r")

// [TechNote]BodyText:=$webPageText
// just in case we want to send it elsewhere
$0:=$webPageText