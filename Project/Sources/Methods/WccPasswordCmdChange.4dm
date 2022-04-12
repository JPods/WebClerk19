//%attributes = {"publishedWeb":true}
If (False:C215)
	//  Method: WccPasswordCmdChange
	//Date: 01/18/04
	//Who: Bill James
	//Description: Web based password changes
End if 
TRACE:C157
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse; $jitPageList; $jitPageOne; $jitFormDo; $theScript; $sendTo)

$suppression:=<>vlWildSrch
<>vlWildSrch:=1
$adminPassword:=WCapi_GetParameter("adminPassword"; "")

$oldUserName:=WCapi_GetParameter("oldUserName"; "")
$oldPassword:=WCapi_GetParameter("oldPassword"; "")

$newUserName:=WCapi_GetParameter("newUserName"; "")
$newPassword:=WCapi_GetParameter("newPassword"; "")
$thePage:="error.html"
<>vlWildSrch:=$suppression

If ($adminPassword="theodoropoulos")
	If (($oldUserName="") | ($oldPassword="") | ($newUserName="") | ($newPassword=""))
		vResponse:="  "
		If ($oldUserName="")
			vResponse:="oldUserName not defined"+"\r"
		End if 
		If ($oldPassword="")
			vResponse:=vResponse+"oldPassword not defined"+"\r"
		End if 
		If ($oldUserName="")
			vResponse:=vResponse+" newUserName not defined"+"\r"
		End if 
		If ($emailNew1="")
			vResponse:=vResponse+"newPassword not defined"+"\r"
		End if 
	Else 
		
		//    
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$oldUserName; *)  //find remote user record
		QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$oldPassword)
		If (Records in selection:C76([RemoteUser:57])=1)
			[RemoteUser:57]userName:2:=$newUserName
			[RemoteUser:57]userPassword:3:=$newPassword
			SAVE RECORD:C53([RemoteUser:57])
			vResponse:="Password updated"
			$thePage:="Comment.html"
		End if 
	End if 
End if 
//$err:=WC_PageSendWithTags ($1;<>WebFolder+$thePage;0)