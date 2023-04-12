//%attributes = {"publishedWeb":true}
////Procedure: http_CheckOut
//C_LONGINT($eventRec; $1; $error; $remoteNum)
//C_TEXT($dottedAddr; $txtPage)
//C_POINTER($2)

////LOAD RECORD([EventLog])
//If ([EventLog]remoteUserRec>-1)
////GOTO RECORD([RemoteUser];[EventLog]RemoteUserRec)
//Case of 
//: ((Record number([RemoteUser])=-1) | ([EventLog]customerRecNum=-1))
//[EventLog]customerRecNum:=-1
//[EventLog]tableNum:=0
//: ([EventLog]tableNum=2)
//GOTO RECORD([Customer]; [EventLog]customerRecNum)
////GOTO RECORD([RemoteUser];$remoteNum)
//[EventLog]tableNum:=2
//: ([EventLog]tableNum=13)
//GOTO RECORD([Contact]; [EventLog]customerRecNum)
//QUERY([Customer]; [Customer]customerID=[Contact]customerID)
////UNLOAD RECORD([Contact])
//: ([EventLog]tableNum=38)
//GOTO RECORD([Vendor]; [EventLog]customerRecNum)
//QUERY([Customer]; [Customer]phone=[Vendor]phone)
//If (Records in selection([Customer])=0)
//Vendor2Customer(2)
//End if 
//[EventLog]tableNum:=2
////UNLOAD RECORD([Vendor])
////: ([EventLog]TableNum=8)
////GOTO RECORD([Rep];[EventLog]CustomerRecNum)
////do this some time
////*****[EventLog]CustomerRecNum:=Record number([Rep])
////*****this creates a problem
////UNLOAD RECORD([Rep])
//Else 
//vResponse:="No Customer, Lead, Contact or Vendor selected."
//End case 
////TRACE
//If (Record number([Customer])>-1)
//$doNew:=False
//Else 
//$doNew:=True
//End if 
//Else 
//REDUCE SELECTION([Customer]; 0)

//$doNew:=True
//End if 
//C_REAL($eventQty)
//$eventQty:=0
//If ([EventLog]qty<1)  //set to avoid a locked eventID when testing
//QUERY([WebTempRec]; [WebTempRec]idEventLog=vleventID; *)
//QUERY([WebTempRec];  & [WebTempRec]qtyOrdered#0; *)
//QUERY([WebTempRec];  & [WebTempRec]posted=False)
//$eventQty:=Sum([WebTempRec]qtyOrdered)
//Else 
//$eventQty:=[EventLog]qty
//End if 

////TRACE
//$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//Case of 
//: ($eventQty=0)
//vResponse:="There are no items in your shopping cart."
//pvWarning:=vResponse
//$doPage:=WC_DoPage("Error.html"; "")
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//: ($doNew)
////$jitPageOne:=WCapi_GetParameter("jitPageRegister";"")

//If ([EventLog]tableNumWccPrime>0)
//vResponse:="You are signed in as Employee or Rep but not for a customer."
//$doPage:=WC_DoPage("WCCCustomersNew.html"; "")
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//Else 
//vResponse:="You have not signed in or must register."
//$doPage:=WC_DoPage("Register.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//End if 
//Else 
//vResponse:="You are registered to proceed."
//If (<>wcbCustomerMods=1)
//vText1:="Changes Accepted"
//Else 
//vText1:="Changes NOT Accepted On-line"
//End if 
////tcPayPath:="/pay_Ord*jitxUser="+String(vleventID)+"*"
////
//Case of 
//: ([Customer]terms="CC_SSLSecure@")  //((<>tcDotted="internal@")&)
//Http_OrdFill($1; $2; False)  //calculate order but do not save     
//// This is so that tcPayPath is set corectly for CustSSLSecure.html
//// after it gets called from the new https:// frame    
//// changed 10/22/01 dan
//If (voState.url="/check_out_Frame@")
//$doPage:=WC_DoPage("Secure_Frameset.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//Else 
//$doPage:=WC_DoPage("CustomersSSLSecure.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//End if 
//: ([Customer]terms="CD_Only@")
//Http_OrdFill($1; $2; False)  //calculate order but do not save
//$doPage:=WC_DoPage("CustomersCDCheck.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//: ([Customer]terms="TC_SSLSecure@")
//Http_OrdFill($1; $2; False)  //calculate order but do not save
//$doPage:=WC_DoPage("CustomersSSLCheck.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//: ([Customer]terms="CC_SSLSecure@")
//Http_OrdFill($1; $2; False)  //calculate order but do not save
//$doPage:=WC_DoPage("SecureCC.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//: ([Customer]terms="CC_jitCorp")
//Http_OrdFill($1; $2; False)  //calculate order but do not save  
//$doPage:=WC_DoPage("CustomersjitCorp.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//: ([Customer]terms="CC_Secure")
//Http_OrdFill($1; $2; False)  //calculate order but do not save     
//$doPage:=WC_DoPage("CustomersSecure.html"; $jitPageOne)
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//Else 
//// ### jwm ### 20180830_1531 added case for signed in as contact
//$ContactRecordNum:=-1
//Case of 
//: ([EventLog]tableNum=13)
//$jitPageOne:=WC_DoPage("ContactsConfirm.html"; $jitPageOne)
//$ContactRecordNum:=Record number([Contact])
//: ([EventLog]tableNum=2)
//$jitPageOne:=WC_DoPage("CustomersConfirm.html"; $jitPageOne)
//Else 
//$jitPageOne:=WC_DoPage("CustomersConfirm.html"; $jitPageOne)
//End case 

//Http_OrdFill($1; $2; False)  //calculate order but do not save 

//// ### jwm ### 20180830_1547 reload contact record if needed
//If ($ContactRecordNum>0)
//GOTO RECORD([Contact]; $ContactRecordNum)
//End if 

//$err:=WC_PageSendWithTags($1; $jitPageOne; 0)

//End case 
//vText1:=""
//ccNumber:=""
//ccExpires:=""
//ccName:=""
//ccZip:=""
//ccCVV:=""
//End case 
//pvWarning:=""
////If ([EventLog]TableNum>0)
////UNLOAD RECORD(Table([EventLog]TableNum)->)
////End if 
//REDUCE SELECTION([Customer]; 0)

//REDUCE SELECTION([RemoteUser]; 0)


