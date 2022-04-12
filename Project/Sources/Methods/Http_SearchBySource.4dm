//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_SearchBySource
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_LONGINT:C283($1; $err; $userRec)
C_POINTER:C301($2)
//
READ WRITE:C146([QQQRemoteUser:57])
READ WRITE:C146([EventLog:75])
C_LONGINT:C283($w; $h; $t)
C_TEXT:C284($cat; $ser; $val; $suffix; $userName; $recordID; $TableNum)
$sourceID:=WCapi_GetParameter("SourceID"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//
vResponse:="Procedure not authorized"
$pageDo:=WC_DoPage("Error.html"; "")  //why is this here
lang:="us"
$suffix:=""
TRACE:C157
If ($sourceID#"")
	[EventLog:75]Source:29:=$sourceID
End if 
$pageDo:=WC_DoPage("Index.html"; $jitPageOne)
$err:=WC_PageSendWithTags($1; $pageDo; 0)