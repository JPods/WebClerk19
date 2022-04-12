//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/09/18, 11:01:11
// ----------------------------------------------------
// Method: http_Register
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)

$doPage:="Register4Error.html"
vResponse:="Invalid registration command"

// example page flows
// Register1AskEmail.html    // ask for their email
// Register2EmailSent.html   // inform them to check their email
// Register3DataCustomers.html   // provide a form to fill data when they click their link in their email
// Register4Error.html  // error page example

Case of 
	: (voState.url="/Register_SendEmail@")  // Step 2, send an email. must be at the end to keep it from stealing other commands.
		RegisterViaEmail($1; $2)
		$doRecord:=False:C215
		
	: (voState.url="/Register_Verified@")  // Step 3 receive response from email
		RegisterVerified($1; $2)
		
	: (voState.url="/Register_Complete@")  // 4th Step 
		// email has been confirmed and the data formed filled out within 2 hours.
		RegisterComplete($1; $2)
		$doRecord:=False:C215
		
	Else 
		
		$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)
		
End case 
// ### bj ### 20181208_1308
// $doPage needs to be the page without the path

custAddress:=""
requestPassword:=""
requestUserName:=""