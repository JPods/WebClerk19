//%attributes = {"publishedWeb":true}
//If (False)
////Date: 07/01/02
////Who: Mike Cassano, IDC WebDev
////Description: Searches RemoteUsers table for an email match, sends email
//End if 
//C_LONGINT($1; $c; $doThis; <>vbSaleLevel)
//C_TEXT(vResponse; $jitPageList; $jitPageOne; $jitFormDo; $theScript; $sendTo)

//$suppression:=<>vlWildSrch
//<>vlWildSrch:=1
//$email:=WCapi_GetParameter("email"; "")
//<>vlWildSrch:=$suppression

//$doPage:=""  // ### jwm ### 20150901_1358

//$email:=$email
//$doSend:=False
//SMTP_SentBy(Current user)

//If ($email="")
//vResponse:="Error: Email Address Required"
//$doPage:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150901_1358
//Else 
////QUERY([RemoteUser];[RemoteUser]Email=$email)
//// exact match using regular expressions
//$vtRegex:="^"+$email+"$"
//QUERY BY FORMULA([RemoteUser]; Preg Match($vtRegex; [RemoteUser]email)=1)  // ### jwm ### 20150916_1640
//QUERY SELECTION([RemoteUser]; [RemoteUser]securityLevel>=2)  // must be an active user  // ### jwm ### 20180507_1100 1 = public pages only
//FIRST RECORD([RemoteUser])
//If (Records in selection([RemoteUser])>0)
//vtEmailReceiver:=[RemoteUser]email
//vtEmailSubject:="Forgotten Password"
//Case of 
//: ([RemoteUser]tableNum=2)
//QUERY([Customer]; [Customer]customerID=[RemoteUser]customerID)
//: ([RemoteUser]tableNum=111)
//QUERY([Customer]; [Customer]customerID=[RemoteUser]customerID)
//QUERY([zManufacturerTerm]; [zManufacturerTerm]customerID=[Customer]customerID)

//: ([RemoteUser]tableNum=38)
//QUERY([Vendor]; [Vendor]vendorID=[RemoteUser]customerID)
//: ([RemoteUser]tableNum=13)
//QUERY([Contact]; [Contact]idNum=Num([RemoteUser]customerID))
//: (vWccTableNum=8)
//QUERY([Employee]; [Employee]emailUserName=[RemoteUser]customerID)
//: (vWccTableNum=19)
//QUERY([Rep]; [Rep]repID=[RemoteUser]customerID)
//End case 
//QUERY([TallyMaster]; [TallyMaster]purpose="WebTemplate"; *)
//QUERY([TallyMaster];  & [TallyMaster]name="SendPasswordEmail")
//If (Records in selection([TallyMaster])=1)
//If ([TallyMaster]profile1#"")
//$doPage:=[TallyMaster]profile1
//End if 
//vtEmailBody:=TagsToText([TallyMaster]build)
//UNLOAD RECORD([TallyMaster])

//Else 
//vtEmailBody:=vtEmailSubject+"\r"+"\r"+"UserName:  "+[RemoteUser]userName
//vtEmailBody:=vtEmailBody+"\r"+"\r"+"Password:  "+[RemoteUser]userPassword
//vtEmailBody:=vtEmailBody+"\r"+"\r"+"Thank you.  Visit us again:  http://"+Storage.default.domain
//End if 

//$doSend:=True
////vResponse:="Expect an email from:  "+vtEmailSender+", Via MailServer: "+vtEmailServer+".  You should recieve it shortly. <br>"
//vResponse:="Please check your inbox for an email from: "+vtEmailSender+"<br> Via MailServer: "+vtEmailServer+"<br>"  // ### jwm ### 20150902_0948
//If (Records in selection([RemoteUser])>1)
//vResponse:=vResponse+String(Records in selection([RemoteUser]))+" users were found."
//End if 

//$doPage:=WCapi_GetParameter("jitPageOne"; "")  // ### jwm ### 20150901_1358

//Else 
////vResponse:="No RemoteUser found with this email, please try again."
//vResponse:="Error: Email Address Not Found, please try again."  // ### jwm ### 20150902_0936

//$doPage:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150901_1358

//End if 
//End if 

//If ($doPage="")
//$doPage:="Comment.html"
//End if 
//$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)
//UNLOAD RECORD([RemoteUser])

//If ($doSend)
//SMTP_SendMsg
//End if 