//%attributes = {"publishedWeb":true}
//Method: Http_PostCC
C_LONGINT:C283($1)
C_POINTER:C301($2)
//
C_LONGINT:C283($p)
//SET TEXT TO CLIPBOARD(vText11)
C_TEXT:C284($workStr; $theReferer)
$p:=Position:C15(Storage:C1525.char.crlf; $2->)
If ($p>0)
	$workStr:=Substring:C12($2->; $p+2)
	$p:=Position:C15(Storage:C1525.char.crlf; $workStr)
	If ($p>0)
		$theReferer:=Substring:C12($workStr; 1; $p-1)
	End if 
End if 
If (<>tcSecure=$theReferer)
	vResponse:="Things are OK."
	
Else 
	vResponse:="You have come from an unathorized source."
	$err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
End if 