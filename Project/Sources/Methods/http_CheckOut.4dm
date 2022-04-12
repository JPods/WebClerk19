//%attributes = {"publishedWeb":true}
//Procedure: http_CheckOut
C_LONGINT:C283($eventRec; $1; $error; $remoteNum)
C_TEXT:C284($dottedAddr; $txtPage)
C_POINTER:C301($2)

//LOAD RECORD([EventLog])
If ([EventLog:75]remoteUserRec:10>-1)
	//GOTO RECORD([RemoteUser];[EventLog]RemoteUserRec)
	Case of 
		: ((Record number:C243([RemoteUser:57])=-1) | ([EventLog:75]customerRecNum:8=-1))
			[EventLog:75]customerRecNum:8:=-1
			[EventLog:75]tableNum:9:=0
		: ([EventLog:75]tableNum:9=2)
			GOTO RECORD:C242([Customer:2]; [EventLog:75]customerRecNum:8)
			//GOTO RECORD([RemoteUser];$remoteNum)
			[EventLog:75]tableNum:9:=2
		: ([EventLog:75]tableNum:9=13)
			GOTO RECORD:C242([Contact:13]; [EventLog:75]customerRecNum:8)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
			//UNLOAD RECORD([Contact])
		: ([EventLog:75]tableNum:9=38)
			GOTO RECORD:C242([Vendor:38]; [EventLog:75]customerRecNum:8)
			QUERY:C277([Customer:2]; [Customer:2]phone:13=[Vendor:38]phone:10)
			If (Records in selection:C76([Customer:2])=0)
				Vendor2Customer(2)
			End if 
			[EventLog:75]tableNum:9:=2
			//UNLOAD RECORD([Vendor])
			//: ([EventLog]TableNum=8)
			//GOTO RECORD([Rep];[EventLog]CustomerRecNum)
			//do this some time
			//*****[EventLog]CustomerRecNum:=Record number([Rep])
			//*****this creates a problem
			//UNLOAD RECORD([Rep])
		Else 
			vResponse:="No Customer, Lead, Contact or Vendor selected."
	End case 
	//TRACE
	If (Record number:C243([Customer:2])>-1)
		$doNew:=False:C215
	Else 
		$doNew:=True:C214
	End if 
Else 
	REDUCE SELECTION:C351([Customer:2]; 0)
	REDUCE SELECTION:C351([zzzLead:48]; 0)
	$doNew:=True:C214
End if 
C_REAL:C285($eventQty)
$eventQty:=0
If ([EventLog:75]qty:6<1)  //set to avoid a locked eventID when testing
	QUERY:C277([WebTempRec:101]; [WebTempRec:101]idEventLog:1=vleventID; *)
	QUERY:C277([WebTempRec:101];  & [WebTempRec:101]qtyOrdered:4#0; *)
	QUERY:C277([WebTempRec:101];  & [WebTempRec:101]posted:5=False:C215)
	$eventQty:=Sum:C1([WebTempRec:101]qtyOrdered:4)
Else 
	$eventQty:=[EventLog:75]qty:6
End if 

//TRACE
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
Case of 
	: ($eventQty=0)
		vResponse:="There are no items in your shopping cart."
		pvWarning:=vResponse
		$doPage:=WC_DoPage("Error.html"; "")
		$err:=WC_PageSendWithTags($1; $doPage; 0)
	: ($doNew)
		//$jitPageOne:=WCapi_GetParameter("jitPageRegister";"")
		
		If ([EventLog:75]tableNumWccPrime:24>0)
			vResponse:="You are signed in as Employee or Rep but not for a customer."
			$doPage:=WC_DoPage("WCCCustomersNew.html"; "")
			$err:=WC_PageSendWithTags($1; $doPage; 0)
		Else 
			vResponse:="You have not signed in or must register."
			$doPage:=WC_DoPage("Register.html"; $jitPageOne)
			$err:=WC_PageSendWithTags($1; $doPage; 0)
		End if 
	Else 
		vResponse:="You are registered to proceed."
		If (<>wcbCustomerMods=1)
			vText1:="Changes Accepted"
		Else 
			vText1:="Changes NOT Accepted On-line"
		End if 
		//tcPayPath:="/pay_Ord*jitxUser="+String(vleventID)+"*"
		//
		Case of 
			: ([Customer:2]terms:33="CC_SSLSecure@")  //((<>tcDotted="internal@")&)
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save     
				// This is so that tcPayPath is set corectly for CustSSLSecure.html
				// after it gets called from the new https:// frame    
				// changed 10/22/01 dan
				If (voState.url="/check_out_Frame@")
					$doPage:=WC_DoPage("Secure_Frameset.html"; $jitPageOne)
					$err:=WC_PageSendWithTags($1; $doPage; 0)
				Else 
					$doPage:=WC_DoPage("CustomersSSLSecure.html"; $jitPageOne)
					$err:=WC_PageSendWithTags($1; $doPage; 0)
				End if 
			: ([Customer:2]terms:33="CD_Only@")
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save
				$doPage:=WC_DoPage("CustomersCDCheck.html"; $jitPageOne)
				$err:=WC_PageSendWithTags($1; $doPage; 0)
			: ([Customer:2]terms:33="TC_SSLSecure@")
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save
				$doPage:=WC_DoPage("CustomersSSLCheck.html"; $jitPageOne)
				$err:=WC_PageSendWithTags($1; $doPage; 0)
			: ([Customer:2]terms:33="CC_SSLSecure@")
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save
				$doPage:=WC_DoPage("SecureCC.html"; $jitPageOne)
				$err:=WC_PageSendWithTags($1; $doPage; 0)
			: ([Customer:2]terms:33="CC_jitCorp")
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save  
				$doPage:=WC_DoPage("CustomersjitCorp.html"; $jitPageOne)
				$err:=WC_PageSendWithTags($1; $doPage; 0)
			: ([Customer:2]terms:33="CC_Secure")
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save     
				$doPage:=WC_DoPage("CustomersSecure.html"; $jitPageOne)
				$err:=WC_PageSendWithTags($1; $doPage; 0)
			Else 
				// ### jwm ### 20180830_1531 added case for signed in as contact
				$ContactRecordNum:=-1
				Case of 
					: ([EventLog:75]tableNum:9=13)
						$jitPageOne:=WC_DoPage("ContactsConfirm.html"; $jitPageOne)
						$ContactRecordNum:=Record number:C243([Contact:13])
					: ([EventLog:75]tableNum:9=2)
						$jitPageOne:=WC_DoPage("CustomersConfirm.html"; $jitPageOne)
					Else 
						$jitPageOne:=WC_DoPage("CustomersConfirm.html"; $jitPageOne)
				End case 
				
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save 
				
				// ### jwm ### 20180830_1547 reload contact record if needed
				If ($ContactRecordNum>0)
					GOTO RECORD:C242([Contact:13]; $ContactRecordNum)
				End if 
				
				$err:=WC_PageSendWithTags($1; $jitPageOne; 0)
				
		End case 
		vText1:=""
		ccNumber:=""
		ccExpires:=""
		ccName:=""
		ccZip:=""
		ccCVV:=""
End case 
pvWarning:=""
//If ([EventLog]TableNum>0)
//UNLOAD RECORD(Table([EventLog]TableNum)->)
//End if 
REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([zzzLead:48]; 0)
REDUCE SELECTION:C351([RemoteUser:57]; 0)


