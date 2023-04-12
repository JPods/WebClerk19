//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/09/18, 11:08:59
// ----------------------------------------------------
// Method: RegisterComplete
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Step 3, last
// email has been confirmed and the data formed filled out within 2 hours.
C_LONGINT:C283($1; $err; $remoteHost; $i; $eMailPass)
C_POINTER:C301($2)

C_TEXT:C284($jitPageOne; $doPage; $jitPageError)
C_TEXT:C284($userEmail; $password; $userName; $code)
$doRecord:=True:C214

$doPage:=WCapi_GetParameter("jitPageError"; "")
If ($doPage="")
	$doPage:="Register4Error.html"
End if 

$code:=WCapi_GetParameter("code"; "")
$userEmail:=WCapi_GetParameter("email"; "")
If ($userEmail="")
	If (Storage:C1525.wc.bWCRegisterLeads)
		$userEmail:=WCapi_GetParameter("_jit_Leads_Emailjj"; "")
	Else 
		$userEmail:=WCapi_GetParameter("_jit_Customers_Emailjj"; "")
	End if 
End if 
C_LONGINT:C283($dtCurrent)
$dtCurrent:=DateTime_DTTo
If (([EventLog:75]id:54=$code) & ([EventLog:75]email:56=$userEmail))
	// found by cookie on the same machine
Else 
	// prevent someone from changing the email or code in the URL
	QUERY:C277([EventLog:75]; [EventLog:75]id:54=$code; *)
	QUERY:C277([EventLog:75];  & ; [EventLog:75]email:56=$userEmail)
End if 


// use a javascript on the page to check password is appropriate
$password:=WCapi_GetParameter("password"; "")



//  QUERY([EventLog];[EventLog]id=$code)
// cookie should already be the selected EventLogs record
If ([EventLog:75]id:54#$code)
	vResponse:="id mismatch: "+$userEmail
Else 
	[EventLog:75]id:54:=[EventLog:75]id:54+"E4"  // prevent them from resubmitting from the email
	C_LONGINT:C283($dtCurrent)
	$dtCurrent:=DateTime_DTTo
	If ($dtCurrent>[EventLog:75]dtExpires:55)
		vResponse:="Registration period expired in 2 hours. Current server time: "+String:C10(Current time:C178)+". Resubmit email: "+$userEmail
	Else 
		// extend valid to one day
		[EventLog:75]dtExpires:55:=[EventLog:75]dtExpires:55+86400
		
		
		CREATE RECORD:C68([Customer:2])
		DB_InitCustomer
		[Customer:2]adSource:62:="webClerk"
		[Customer:2]action:60:="New Registration"
		WC_Parse(2; $2)  //      automatically fill in customerID  
		//P_FillVars(->[Customer])
		// ### bj ### 20181211_0945  after parsing
		[Customer:2]email:81:=[EventLog:75]email:56  // do not allow a page change to change data
		[Customer:2]actionDate:61:=Current date:C33
		[Customer:2]typeSale:18:=<>vWebPrice
		[EventLog:75]tableNum:9:=2
		[EventLog:75]company:46:=[Customer:2]company:2
		[EventLog:75]status:48:="EmailVerified"
		[EventLog:75]securityLevel:16:=2
		SAVE RECORD:C53([EventLog:75])
		vUseBase:=SetPricePoint([Customer:2]typeSale:18)
		SAVE RECORD:C53([Customer:2])  // get Record Number before creating the RemoteUser Record
		viEndUserSecurityLevel:=0
		[EventLog:75]customerRecNum:8:=Record number:C243([Customer:2])
		SAVE RECORD:C53([EventLog:75])
		If (viEndUserSecurityLevel#0)  // ### bj ### 20181211_1254 changed in the script
			[EventLog:75]securityLevel:16:=viEndUserSecurityLevel
		End if 
		// ### bj ### 20190217_0010
		// WC_Parse  > > WccAcceptTasks creates a RemoteUser
		//RemoteUser_Create (->[Customer];[EventLog]Email;$password;[EventLog]SecurityLevel)
		[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
		SAVE RECORD:C53([EventLog:75])
		
		C_TEXT:C284(jitPageFromScript)
		jitPageFromScript:=""
		// viEndUserSecurityLevel  // can use variable or change the field values in the script
		Execute_TallyMaster("RegisterCustomers"; "WebClerk")
		// ### bj ### 20181211_2325
		// cleanup and adjust Customers, RemoteUser and Eventlogs
		
		Execute_TallyMasterNewProcess("NewCustomers"; "WebClerk")
		// remote task for other activities
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		If ($jitPageOne="")
			$jitPageOne:="CustomersOne.html"
		End if 
		
		SAVE RECORD:C53([EventLog:75])
		// Modified by: Bill James (2016-12-02T00:00:00)
		// always register web entries as customer, never as leads.
		// If (<>vWebCustomerDirect=1)
		// set vtEmailReceiver := "" in script to not send confirming email
		EmailByTallyMaster($userEmail; "registerconfirm"; "WebClerk")
		
		
	End if 
	
	RemoteUsers_SetVars(6)
	
	SAVE RECORD:C53([EventLog:75])
	
	$doPage:=$jitPageOne
End if 
$doPage:=WC_DoPage($doPage; "")  // add the path to the page
$err:=WC_PageSendWithTags($1; $doPage; 0)
