//%attributes = {"publishedWeb":true}
//Procedure: Http_ForumNew
C_LONGINT:C283($1)
C_TEXT:C284($suffix; $uniqueID)
C_POINTER:C301($2)
UNLOAD RECORD:C212([Forum:80])

If ([EventLog:75]RemoteUserRec:10>-1)
	$err:=WC_PageSendWithTags($1; WC_DoPage("ForumNew"+$suffix+".html"; ""); 0)
Else 
	vResponse:="You are not registered or you have not signed in yet."
	$err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; ""); 0)
End if 
