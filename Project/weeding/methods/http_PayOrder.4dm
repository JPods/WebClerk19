//%attributes = {"publishedWeb":true}
//Procedure: http_PayOrder
C_LONGINT:C283($1; $p)
C_POINTER:C301($2)
C_DATE:C307($ccDate)

C_TEXT:C284(<>ccWebNum; <>ccWebDate; <>ccWebName)
C_TEXT:C284($doSecure; $payType; $creditCard; $exDate)
C_TEXT:C284(<>eMailAddr; $cardName)
//
C_BOOLEAN:C305($gotCC)
//
$suffix:=""
C_TEXT:C284($suffix; lang)
C_REAL:C285($ordVal)

C_TEXT:C284($PaymentType)
$PaymentType:=WCapi_GetParameter(<>tcCCNamePayType; "")
//TRACE

$gotCC:=((voState.url="/CCpay_Ord@") | (vWccSecurity>4))  //"CCpay_Ord" must be the form action
If ($gotCC)  //if coming from other server or service center recapture the eventI
	vText12:=$2->  //copy the incoming text
	
End if 
Case of   //get the customer
	: ([EventLog:75]tableNum:9=0)
	: (([EventLog:75]tableNum:9=2) & ([EventLog:75]customerRecNum:8>-1))
		GOTO RECORD:C242([Customer:2]; [EventLog:75]customerRecNum:8)
		Http_SaveRecord($1; $2; False:C215)
End case 
//not needed at this point ??
If ([Customer:2]terms:33="CC_SSLSecure")  //copy the incoming text before order parsing
	vText12:=$2->
	tcCheckOutPath:=tcSSLSecure+"/Check_Out"+"_"+<>tcSSLUser+"_"+<>tcDotted  //+"*jitxUser="+String(vleventID)+"*"
Else 
	tcCheckOutPath:="/Check_Out"  //*jitxUser="+String(vleventID)+"*"
End if 
QUERY:C277([WebTempRec:101]; [WebTempRec:101]idEventLog:1=vleventID; *)
QUERY:C277([WebTempRec:101];  & [WebTempRec:101]qtyOrdered:4#0; *)
QUERY:C277([WebTempRec:101];  & [WebTempRec:101]posted:5=False:C215)

Case of 
	: (Records in selection:C76([WebTempRec:101])=0)
		DELAY PROCESS:C323(Current process:C322; 360)
		vResponse:="There is nothing in your shopping cart."+"\r"
		$err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
	: ([EventLog:75]tableNum:9=0)  //if not signed in, get registration
		vResponse:="Sign-in or complete registration."
		$err:=WC_PageSendWithTags($1; WC_DoPage("Register.html"; ""); 0)
	: (([EventLog:75]tableNum:9>0) & ([EventLog:75]remoteUserRec:10>-1))
		Case of 
			: ((Not:C34($gotCC)) & ([Customer:2]terms:33="CC_Secure"))
				Http_OrdFill($1; $2; False:C215)  //calculate order but do not save
				$err:=WC_PageSendWithTags($1; WC_DoPage("SecureCC.html"; ""); 0)
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
				//: ((Not($gotCC))&([Customer]Terms="CC_SSLSecure"))
			: (($PaymentType="ChargeAtOrder") & ([Customer:2]terms:33="CC_Secure"))
				GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
				Http_OrdFill($1; $2; False:C215)
				
				//Dan; Arkware (10/23/01)
				333Http_PayAdd(0; ->vText12; True:C214)  //pass in the captured text
				
				If (Is new record:C668([Payment:28]))
					vResponse:="Credit Card not accepted"
					$err:=WC_PageSendWithTags($1; WC_DoPage("SecureCC"+$suffix+".html"; ""); 0)
					If ([EventLog:75]idNum:5#0)
						SAVE RECORD:C53([EventLog:75])
					End if 
				Else 
					GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
					Http_OrdFill($1; $2; True:C214)
					
					$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
					$jitPageOne:=WC_DoPage("OrdersOne.html"; $jitPageOne)
					$err:=WC_PageSendWithTags($1; $jitPageOne; 0)
				End if 
			: (($PaymentType="ChargeAtOrder") & ([Customer:2]terms:33="CC_SSLSecure"))
				// Added by Arkware (08/23/01)
				//     
				Http_OrdFill($1; $2; False:C215)
				
				//Dan; Arkware (10/23/01)
				333Http_PayAdd(0; ->vText12; True:C214)  //pass in the captured text
				
				// Show Order Complete Page if authorized, otherwise return them to the cc screen
				C_TEXT:C284($ResultPage)
				If (vCCStatus#<>ciTASAuthed)  // Status code returned from CC_Authorize in 333Http_PayAdd
					vResponse:="There was an error processing your credit card: "+vCCAuthError
					$jitPageOne:=WC_DoPage("CustSSLSecure.html"; "")
				Else 
					Http_OrdFill($1; $2; True:C214)
					//$ResultPage:=<>WebFolder+"OrderCmplt"+$suffix+".html"
					$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
					$jitPageOne:=WC_DoPage("OrdersOne.html"; $jitPageOne)
					$err:=WC_PageSendWithTags($1; $jitPageOne; 0)
				End if 
				
				// Send Result Page to user
				$err:=WC_PageSendWithTags($1; $jitPageOne; 0)
			Else 
				GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
				
				
				Http_OrdFill($1; $2; True:C214)
				If (($gotCC) | ([Customer:2]terms:33="CC_SSLSecure"))
					//Dan; Arkware (10/23/01)          
					333Http_PayAdd(0; ->vText12; False:C215)  //pass in the captured text
					
					
					
				End if 
				//
				//If (<>viDoHttpLog>10)
				//http_SendLog ($1;"/Add ord -> ADDED")
				//End if 
				
				FIRST RECORD:C50([OrderLine:49])
				//set parameter 3 to -3 to force an email to the end user
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$jitPageOne:=WC_DoPage("OrdersOne.html"; $jitPageOne)
				
				$err:=WC_PageSendWithTags($1; $jitPageOne; 0)
		End case 
	Else 
		vResponse:=""
		If ([EventLog:75]tableNum:9>0)
			vResponse:=vResponse+"Must be a customer to clone orders, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)+"\r"
		Else 
			vResponse:="You must be signed in as a customer to process an order."+"\r"
		End if 
		$err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; ""); 0)
End case 
vText3:=""
vText2:=""
pPayAmount:=0
pPayTendered:=0
pPayChange:=0
pPayBalance:=0
//