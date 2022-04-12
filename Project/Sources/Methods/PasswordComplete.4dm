//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/18, 00:33:43
// ----------------------------------------------------
// Method: PasswordComplete
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $err; $remoteHost; $i; $eMailPass)
C_POINTER:C301($2)

C_TEXT:C284($jitPageOne; $doPage; $jitPageError)
C_TEXT:C284($userEmail; $password; $userName; $code)
$doRecord:=True:C214

$doPage:=WCapi_GetParameter("jitPageError"; "")
If ($doPage="")
	$doPage:="Password4Error.html"
End if 

$code:=WCapi_GetParameter("code"; "")
$userEmail:=WCapi_GetParameter("email"; "")
// use a javascript on the page to check password is appropriate
$password:=WCapi_GetParameter("password"; "")

C_LONGINT:C283($dtCurrent)
$dtCurrent:=DateTime_Enter
If (([EventLog:75]id:54=$code) & ([EventLog:75]email:56=$userEmail))
	// found by cookie on the same machine
Else 
	// prevent someone from changing the email or code in the URL
	QUERY:C277([EventLog:75]; [EventLog:75]id:54=$code; *)
	QUERY:C277([EventLog:75];  & ; [EventLog:75]email:56=$userEmail)
End if 


//  QUERY([EventLog];[EventLog]id=$code)
// cookie should already be the selected EventLogs record
If ([EventLog:75]id:54#$code)
	vResponse:="id mismatch: "+$userEmail
Else 
	[EventLog:75]id:54:=[EventLog:75]id:54+"E4"
	C_LONGINT:C283($dtCurrent)
	$dtCurrent:=DateTime_Enter
	If ($dtCurrent>[EventLog:75]dtExpires:55)
		vResponse:="Error: Password period expired. Current server time: "+String:C10(Current time:C178)+". Resubmit email: "+$userEmail
		WC_LogEvent("Password change failed, expired: "+[RemoteUser:57]userPassword:3)
	Else 
		// extend valid to one day
		[EventLog:75]dtExpires:55:=[EventLog:75]dtExpires:55+86400
		
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]email:14=$userEmail)
		If (Records in selection:C76([RemoteUser:57])=1)
			If (Locked:C147([RemoteUser:57]))
				vResponse:="Error: Your record is currently locked by the server."
			Else 
				vUsePricePoint:=""
				pvTypeSale:=""
				vResponse:="Password is updated."
				WC_LogEvent("Password change: "+[RemoteUser:57]userPassword:3+": "+$password)
				If (<>VIDEBUGMODE>410)
					ConsoleMessage([RemoteUser:57]email:14+" : Password change: "+[RemoteUser:57]userPassword:3+": "+$password)
				End if 
				[RemoteUser:57]userPassword:3:=$password
				[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
				vlUserRec:=[EventLog:75]remoteUserRec:10
				eMailAddress:=[RemoteUser:57]email:14
				viEndUserSecurityLevel:=[RemoteUser:57]securityLevel:4
				SAVE RECORD:C53([EventLog:75])
				SAVE RECORD:C53([RemoteUser:57])
				Case of 
					: ([RemoteUser:57]tableNum:9=Table:C252(->[Customer:2]))
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
						vUsePricePoint:=[Customer:2]typeSale:18
						pvTypeSale:=[Customer:2]typeSale:18
						$doPage:="CustomersOne.html"
					: ([RemoteUser:57]tableNum:9=Table:C252(->[Employee:19]))
						QUERY:C277([Employee:19]; [Employee:19]nameID:1=[RemoteUser:57]customerID:10)
						$doPage:="EmployeesOne.html"
					: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
						QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([RemoteUser:57]customerID:10))
						$doPage:="ContactsOne.html"
					: ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))
						QUERY:C277([Rep:8]; [Rep:8]RepID:1=[RemoteUser:57]customerID:10)
						$doPage:="RepsOne.html"
					: ([RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38]))
						QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[RemoteUser:57]customerID:10)
						$doPage:="VendorsOne.html"
					: ([RemoteUser:57]tableNum:9=Table:C252(->[zzzLead:48]))
						QUERY:C277([zzzLead:48]; [zzzLead:48]idNum:32=Num:C11([RemoteUser:57]customerID:10))
						$doPage:="LeadsOne.html"
						vUsePricePoint:=[zzzLead:48]typeSale:30
						pvTypeSale:=[zzzLead:48]typeSale:30
				End case 
				viSecureLvl:=[RemoteUser:57]securityLevel:4
				[EventLog:75]securityLevel:16:=[RemoteUser:57]securityLevel:4
				SAVE RECORD:C53([EventLog:75])
			End if 
			
			// Modified by: Bill James (2016-12-02T00:00:00)
			// always register web entries as customer, never as leads.
			// If (<>vWebCustomerDirect=1)
			
			// option to send a confirming email????
			jitPageOne:=""
			EmailByTallyMaster($userEmail; "passwordconfirmed"; "WebClerk")
			If (jitPageOne#"")
				$doPage:=jitPageOne
			End if 
			If (False:C215)
				$doPage:=WCapi_GetParameter("jitPageOne"; "")
				If ($doPage="")
					$doPage:="Password3Confirm.html"
				End if 
			End if 
		End if 
	End if 
	SAVE RECORD:C53([EventLog:75])
	
End if 

If (<>videbugmode=311)
	ConsoleMessage(vResponse)
End if 


$doPage:=WC_DoPage($doPage; "")  // add the path to the page
$err:=WC_PageSendWithTags($1; $doPage; 0)

