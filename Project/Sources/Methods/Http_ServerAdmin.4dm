//%attributes = {"publishedWeb":true}
//Method: Http_ServerAdmin
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_LONGINT:C283($w; $k)
$c:=$1
$suffix:=""
$doThis:=0
//zttp_UserGet 
vResponse:="Feature not available"
$doPage:=WC_DoPage("Comment.html"; "")
$doReStart:=False:C215
Case of 
	: ((voState.url="/Admin_ChangeFolder@") & (<>vSiteSwitching>0))
		$jitPageOne:=WCapi_GetParameter("WebSiteChange"; "")
		$theSite:=Storage:C1525.folder.jitF+$jitPageOne+Folder separator:K24:12
		If ($jitPageOne#"")
			If ((HFS_Exists($theSite)=1) & ($jitPageOne="jitWeb@"))
				READ WRITE:C146([EventLog:75])
				$doPage:=WC_DoPage("Index.html"; "")
				//[EventLog]WebClerkPath:=$jitPageOne  // ### jwm ### 20181217_1545
				vWebClerkPath:=$jitPageOne
				EventLogsMessage("$jitPageOne = "+vWebClerkPath)
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
			End if 
		End if 
	: (viEndUserSecurityLevel<20)
		vResponse:="Not authorized user level for this feature."
		
	: (voState.url="/Admin_Objects@")  //restart webclerk
		WC_LoadObjects
	: (voState.url="/Admin_Process@")  //restart webclerk
		vResponse:="Process Status"
		
	: (voState.url="/Admin_Restart@")  //restart webclerk
		$k:=0
		$doReStart:=True:C214
		vResponse:="Process Start and Stop Initiated."
	: (voState.url="/Admin_ClearPages@")  //pay the order
		If (False:C215)
			If (viEndUserSecurityLevel>15)
				vResponse:="The page arrays have been reset."
			Else 
				vResponse:="Your do not have authority to reset page arrays."
			End if 
		End if 
	: (voState.url="/Admin_ResetTimedEvents@")  //pay the order
		//look at reseting CronJobs
	Else 
		vResponse:="No records found matching search and user level."
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)

If ($doReStart)
	WC_StartEndBegin
End if 
vResponse:=""
vcustomerID:=""