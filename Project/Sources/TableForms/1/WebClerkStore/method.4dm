// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-12T00:00:00, 05:15:05
// ----------------------------------------------------
// Method: [Control].WebClerkStore
// Description
// Modified: 02/12/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		vURL:="http://www.webclerk.com"
		// vURL:="localhost:8080"
		WA OPEN URL:C1020(WebBrowser; vURL)
	End if 
	//
	C_LONGINT:C283($formEvent)
	// $formEvent:=iLoProcedure (->[dBOM])
	//
	$doMore:=False:C215
	
	If ($doMore)
		
		
		
	End if 
	booAccept:=True:C214
End if 