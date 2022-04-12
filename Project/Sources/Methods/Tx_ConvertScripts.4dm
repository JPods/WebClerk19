//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 11/04/09, 10:33:17
// ----------------------------------------------------
// Method: Tx_ConvertScripts
// Description
// WC:_jwm_20091104 conversion for Special Discounts and ItemDiscounts
//
// Parameters
// ----------------------------------------------------
//Method: Tx_ConvertScripts
//### jwm ### 20130816_1644 added Unicode Mode for characters over 127


C_TEXT:C284($theClip)
C_BOOLEAN:C305($doClip)
C_TEXT:C284($1; $0)
$0:=""
If (Count parameters:C259=0)
	$theClip:=Get text from pasteboard:C524
	$doClip:=True:C214
Else 
	$theClip:=$1
	$doClip:=False:C215
End if 
If (Length:C16($theClip)>0)
	// Modified by: williamjames (110318)
	
	
	// ### jwm ### 20190116_0110 variable Name Changes
	// ### jwm ### 20190221_1416 updated to Grep Matching
	
	
	If (False:C215)
		$theClip:=Preg Replace("(?is)\\beAttachment\\b"; "vtEmailAttachment"; $theClip)
		$theClip:=Preg Replace("(?is)\\beAttachment\\b"; "vtEmailAttachment"; $theClip)
		$theClip:=Preg Replace("(?is)\\beAttachmentArray\\b"; "atEmailAttachments"; $theClip)
		$theClip:=Preg Replace("(?is)\\beBCCopy\\b"; "atEmailBCC"; $theClip)
		$theClip:=Preg Replace("(?is)\\beBody\\b"; "vtEmailBody"; $theClip)
		$theClip:=Preg Replace("(?is)\\beCCopy\\b"; "atEmailCC"; $theClip)
		$theClip:=Preg Replace("(?is)\\beMailPassword\\b"; "vtEmailPassword"; $theClip)
		$theClip:=Preg Replace("(?is)\\beMailServer\\b"; "vtEmailServer"; $theClip)
		$theClip:=Preg Replace("(?is)\\beMailUserName\\b"; "vtEmailUserName"; $theClip)
		//$theClip:=Preg Replace("(?is)\beMessage\b";"vtEmailMessage";$theClip)
		$theClip:=Preg Replace("(?is)\\beMessageLog\\b"; "vtEmailMessageLog"; $theClip)
		$theClip:=Preg Replace("(?is)\\beOptOut\\b"; "vtEmailOptOut"; $theClip)
		$theClip:=Preg Replace("(?is)\\bePath\\b"; "vtEmailPath"; $theClip)
		$theClip:=Preg Replace("(?is)\\beReceiver_Tag\\b"; "vtEmailReceiver_Tag"; $theClip)
		$theClip:=Preg Replace("(?is)\\beReceiver\\b"; "vtEmailReceiver"; $theClip)
		$theClip:=Preg Replace("(?is)\\beReplyTo\\b"; "vtEmailReplyTo"; $theClip)
		$theClip:=Preg Replace("(?is)\\beReport\\b"; "vtEmailReport"; $theClip)
		$theClip:=Preg Replace("(?is)\\beSender\\b"; "vtEmailSender"; $theClip)
		$theClip:=Preg Replace("(?is)\\beSenderID\\b"; "vtEmailSenderID"; $theClip)
		$theClip:=Preg Replace("(?is)\\beSenderOverRide_Tag\\b"; "vtEmailSenderOverRide_Tag"; $theClip)
		$theClip:=Preg Replace("(?is)\\beSenderOverride\\b"; "vtEmailSenderOverRide"; $theClip)
		$theClip:=Preg Replace("(?is)\\beSubject\\b"; "vtEmailSubject"; $theClip)
		$theClip:=Preg Replace("(?is)\\bvEmailStatusMessage\\b"; "vtEmailStatusMessage"; $theClip)
		
	End if 
	
	
	
	$theClip:=Replace string:C233($theClip; "\\\r\n"; "")  // ### jwm ### 20171030_1331 line continuation Dos
	$theClip:=Replace string:C233($theClip; "\\\n"; "")  // ### jwm ### 20171030_1331 line continuation Unix
	$theClip:=Replace string:C233($theClip; "\\\r"; "")  // ### jwm ### 20171030_1331 line continuation Mac
	
	//$theClip:=Replace string($theClip;"-===================================================";"//===================================================")  // ### jwm ### 20160927_1114 fix typo
	
	
	If ($theClip="@[Item]Keywords@") & ($theClip#"@[Item]KeywordsSub@")
		$theClip:=Replace string:C233($theClip; "[Item]Keywords"; "[Item]KeywordsSub")
	End if 
	If ($theClip="@[Contact]KeyWords@") & ($theClip#"@[Contact]KeyWordsText@")
		$theClip:=Replace string:C233($theClip; "[Contact]KeyWords"; "[Contact]KeyWordsText")
	End if 
	
	If (Application version:C493="13@")  //### jwm ### 20131015_1650 4D v13 specific changes
		If ($theClip="@Set Enterable@") & ($theClip#"@Object Set Enterable@")
			$theClip:=Replace string:C233($theClip; "Set Enterable"; "Object Set Enterable")
		End if 
		//### jwm ### 20131017_2029 prevent Footrunner 13.0.0 from treating a URL as a comment
		$theClip:=Replace string:C233($theClip; "://"; ":\"+char(47)+char(47)+\"")
	End if 
	
	
	//  $theClip:=Replace string($theClip;"]Keywords"+char(34);"]KeywordText"+char(34))
	
	
	//  $theClip:=Replace string($theClip;"";" ")
	
	// Compatability Mode ASCII 
	
	$theClip:=Replace string:C233($theClip; Char:C90(0x00A0); " ")  // ###_jwm_### 20100913 non-breaking space inserted by 4D editor
	$theClip:=Replace string:C233($theClip; Char:C90(0x25CA); "<>")
	$theClip:=Replace string:C233($theClip; Char:C90(0x00AB); "->")
	$theClip:=Replace string:C233($theClip; Char:C90(0x00BB); "->")
	$theClip:=Replace string:C233($theClip; Char:C90(0x2020); " ")
	
	//
	// Modified by: Bill James (2017-08-21T00:00:00 - missing specialCharacter to x)
	$theClip:=Replace string:C233($theClip; ">>"; "->")
	$theClip:=Replace string:C233($theClip; "''"; Char:C90(34))
	$theClip:=Replace string:C233($theClip; "//"; "//")
	
	$0:=$theClip
End if 