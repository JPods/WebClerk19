//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-03T00:00:00, 18:44:43
// ----------------------------------------------------
// Method: WC_PathRemoteTest
// Description
// Modified: 09/03/17
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305(<>vbWCPathRemote)
C_TEXT:C284(<>vWCPathRemoteViaWeb; $workingText)
<>vbWCPathRemote:=[WebClerk:78]pathRemoteUse:38
$p:=(Position:C15("jitWeb"; [WebClerk:78]pathToRemote:17))
$workingText:=Substring:C12([WebClerk:78]pathToRemote:17; $p+5)
$workingText:=Replace string:C233($workingText; "/"; Folder separator:K24:12)
$workingText:=Replace string:C233($workingText; ":"; Folder separator:K24:12)
$p:=Position:C15(Folder separator:K24:12; $workingText)
If ($p>0)
	$workingText:=Substring:C12($workingText; $p+1)
	$workingText:=Replace string:C233($workingText; Folder separator:K24:12; "/")
	If (Length:C16($workingText)>0)
		If ($workingText[[Length:C16($workingText)]]="/")
			$workingText:=Substring:C12($workingText; 1; Length:C16($workingText)-1)
		End if 
	End if 
End if 
<>vWCPathRemoteViaWeb:=[WebClerk:78]pathRemoteViaWeb:39+$workingText