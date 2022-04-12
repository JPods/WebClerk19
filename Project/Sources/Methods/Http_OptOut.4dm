//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_OptOut  
	//Date: 07/01/02
	//Who: Mike Cassano, IDC WebDev
	//Description: Searches Customer/Lead/Contact/RemoteUser table to set optout flag
	//value added to Leads/Customers/Contact records
End if 
TRACE:C157
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse; $jitPageList; $jitPageOne; $jitFormDo; $theScript; $sendTo)

$suppression:=<>vlWildSrch
<>vlWildSrch:=1
$email:=WCapi_GetParameter("email"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
<>vlWildSrch:=$suppression
$email:=$email
//
$action:=WCapi_GetParameter("OptOut_Action"; "")
//
If (OptOut_Action="Process_OptOut")
	$doPage:=WC_DoPage("OptOutProcessed.html"; $jitPageOne)
	$p:=New process:C317("Email_OptOut"; <>tcPrsMemory; "EmailOptOut"; $email; $action; $2->)
Else 
	$doPage:="OptOutRequest.html"
End if 
$err:=WC_PageSendWithTags($1; <>WebFolder+$doPage; 0)

