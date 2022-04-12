//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-29T00:00:00, 16:13:00
// ----------------------------------------------------
// Method: WC_PageDocOut
// Description
// Modified: 08/29/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171005_1700 moved debug 411 from WC_Core to WC_PageDocOut

C_LONGINT:C283($err; $0; $socket; $1)
$socket:=voState.socket
C_BOOLEAN:C305($pageDo)
C_TEXT:C284($vtPath; $vtPage)
$vtPage:=voState.request.URL.pathNameTrimmed
If ($vtPage="/")
	$vtPage:="index.html"
End if 
// ### bj ### 20201226_1134

$pageDo:=True:C214
$p:=Position:C15(".htm"; $vtPage)
If ($p<1)
	$p:=Position:C15(".ajax"; $vtPage)
	If ($p<1)
		$p:=Position:C15(".json"; $vtPage)
		If ($p<1)
			$p:=Position:C15(".csv"; $vtPage)
			If ($p<1)
				$p:=Position:C15(".wc"; $vtPage)
				If ($p<1)
					$p:=Position:C15(".txt"; $vtPage)
					If ($p<1)
						$p:=Position:C15(".xml"; $vtPage)
						If ($p<1)
							$p:=Position:C15(".shtml"; $vtPage)
							If ($p<1)
								$pageDo:=False:C215  //this is something other than a page or a known image
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

$vtPath:=<>WebFolder+Replace string:C233($vtPage; "/"; Folder separator:K24:12)
If (Position:C15(Folder separator:K24:12+Folder separator:K24:12; $vtPath)>0)
	$vtPath:=Replace string:C233($vtPath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)  // protection against double //
End if 
// ### bj ### 20210912_1319  No more pages with tags
$pageDo:=False:C215
If ($pageDo)
	$err:=WC_PageSendWithTags($socket; $vtPath; 0)
Else 
	WC_SendServerResponsePath($vtPath)
End if 
