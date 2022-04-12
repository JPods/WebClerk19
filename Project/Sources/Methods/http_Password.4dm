//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/18, 21:06:00
// ----------------------------------------------------
// Method: http_Password
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284(vResponse; $userEmail)
C_POINTER:C301($2)
// https://www.webdesignerdepot.com/2012/01/password-strength-verification-with-jquery/
Case of 
	: (voState.url="/Password_Reset@")  // Step 2, send an email. must be at the end to keep it from stealing other commands.
		PasswordReset($1; $2)
		
	: (voState.url="/Password_Verified@")  // Step 3 receive response from email
		PasswordVerified($1; $2)
		
	: (voState.url="/Password_Complete@")  // 4th Step 
		// email has been confirmed and the data formed filled out within 2 hours.
		PasswordComplete($1; $2)
		
End case 