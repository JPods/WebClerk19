//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 07/01/02
	//Who: Mike Cassano, IDC WebDev
	//Description: Searches RemoteUsers table for an email match, sends email
End if 
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse; $jitPageList; $jitPageOne; $jitFormDo; $theScript; $sendTo)

$suppression:=<>vlWildSrch
<>vlWildSrch:=1
$email:=WCapi_GetParameter("email"; "")
<>vlWildSrch:=$suppression

$doPage:=""  // ### jwm ### 20150901_1358

$email:=$email
$doSend:=False:C215
SMTP_SentBy(Current user:C182)

If ($email="")
	vResponse:="Error: Email Address Required"
	$doPage:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150901_1358
Else 
	//QUERY([RemoteUser];[RemoteUser]Email=$email)
	// exact match using regular expressions
	$vtRegex:="^"+$email+"$"
	QUERY BY FORMULA:C48([RemoteUser:57]; Preg Match($vtRegex; [RemoteUser:57]email:14)=1)  // ### jwm ### 20150916_1640
	QUERY SELECTION:C341([RemoteUser:57]; [RemoteUser:57]securityLevel:4>=2)  // must be an active user  // ### jwm ### 20180507_1100 1 = public pages only
	FIRST RECORD:C50([RemoteUser:57])
	If (Records in selection:C76([RemoteUser:57])>0)
		vtEmailReceiver:=[RemoteUser:57]email:14
		vtEmailSubject:="Forgotten Password"
		Case of 
			: ([RemoteUser:57]tableNum:9=2)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
			: ([RemoteUser:57]tableNum:9=111)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
				QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
			: ([RemoteUser:57]tableNum:9=48)
				QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([RemoteUser:57]customerID:10))
			: ([RemoteUser:57]tableNum:9=38)
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[RemoteUser:57]customerID:10)
			: ([RemoteUser:57]tableNum:9=13)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([RemoteUser:57]customerID:10))
			: (vWccTableNum=8)
				QUERY:C277([Employee:19]; [Employee:19]emailUserName:60=[RemoteUser:57]customerID:10)
			: (vWccTableNum=19)
				QUERY:C277([Rep:8]; [Rep:8]repID:1=[RemoteUser:57]customerID:10)
		End case 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="WebTemplate"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="SendPasswordEmail")
		If (Records in selection:C76([TallyMaster:60])=1)
			If ([TallyMaster:60]profile1:23#"")
				$doPage:=[TallyMaster:60]profile1:23
			End if 
			vtEmailBody:=TagsToText([TallyMaster:60]build:6)
			UNLOAD RECORD:C212([TallyMaster:60])
			
		Else 
			vtEmailBody:=vtEmailSubject+"\r"+"\r"+"UserName:  "+[RemoteUser:57]userName:2
			vtEmailBody:=vtEmailBody+"\r"+"\r"+"Password:  "+[RemoteUser:57]userPassword:3
			vtEmailBody:=vtEmailBody+"\r"+"\r"+"Thank you.  Visit us again:  http://"+Storage:C1525.default.domain
		End if 
		
		$doSend:=True:C214
		//vResponse:="Expect an email from:  "+vtEmailSender+", Via MailServer: "+vtEmailServer+".  You should recieve it shortly. <br>"
		vResponse:="Please check your inbox for an email from: "+vtEmailSender+"<br> Via MailServer: "+vtEmailServer+"<br>"  // ### jwm ### 20150902_0948
		If (Records in selection:C76([RemoteUser:57])>1)
			vResponse:=vResponse+String:C10(Records in selection:C76([RemoteUser:57]))+" users were found."
		End if 
		
		$doPage:=WCapi_GetParameter("jitPageOne"; "")  // ### jwm ### 20150901_1358
		
	Else 
		//vResponse:="No RemoteUser found with this email, please try again."
		vResponse:="Error: Email Address Not Found, please try again."  // ### jwm ### 20150902_0936
		
		$doPage:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150901_1358
		
	End if 
End if 

If ($doPage="")
	$doPage:="Comment.html"
End if 
$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)
UNLOAD RECORD:C212([RemoteUser:57])

If ($doSend)
	SMTP_SendMsg
End if 