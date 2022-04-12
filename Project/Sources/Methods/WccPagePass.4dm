//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccPagePass
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284(pvPageReturn; pvTableName)
//
vResponse:="Page is not available"
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
pvPageReturn:=WCapi_GetParameter("jitPageReturn"; "")
pvRecordReturn:=WCapi_GetParameter("RecordReturn"; "")
pvTableReturn:=WCapi_GetParameter("TableReturn"; "")
pvTaskReturn:=WCapi_GetParameter("TaskReturn"; "")
$pageDo:=WC_DoPage("Error.html"; $jitPageOne)
$err:=WC_PageSendWithTags($1; $pageDo; 0)