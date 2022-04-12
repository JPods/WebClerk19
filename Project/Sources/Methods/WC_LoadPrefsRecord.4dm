//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 10/13/17, 10:41:43
// ----------------------------------------------------
// Method: WC_LoadPrefsRecord
// Description: LOAD THE CORRECT WEBCLERK RECORD
// 
//
// Parameters
// ----------------------------------------------------

// PARAMETER 1 IS THE UNPARSED TAG TEXT
C_BOOLEAN:C305($0; $vbLaunch)
$vbLaunch:=False:C215

// ### JWM ### 20171016_1820 launch console if needed to display error messages
If (<>consoleProcess=0)
	ConsoleMessage("Launch")
End if 

// IF WE HAVE A WEBCLERK RECORD OPEN, USE IT. THIS IS THE TOP LEVEL OVERRIDE.
// ### bj ### 20190806_1221  This was changed from the published level to the machine name. Document this change.
// changed to first the record, then the machine name and then the published level
// This limits a machine to one web site on one set of ports. This likely needs to change so we can have
// multiple databases on different ports serving for various purposes or small companies.

// LAYOUTCHANGE   // ### bj ### 20190806_1239 to show the publish nature at the top

// ### bj ### 20210822_1422
DefaultSetupsCreate("<>vtQueryBy"; "contains"; "is text"; "WebClerk"; ""; "contains, object, keyword: in ajax_QueryKeyword")
<>vtQueryBy:=DefaultSetupsReturnValue("<>vtQueryBy")
REDUCE SELECTION:C351([DefaultSetup:86]; 0)

If (vHere=2)
	
	ONE RECORD SELECT:C189([WebClerk:78])
	
	ConsoleMessage("WebClerk Preferences From Input Layout: \rMachine = "+String:C10([WebClerk:78]machine:35)+"\rPublish = "+String:C10([WebClerk:78]publish:7)+"\rSequence = "+String:C10([WebClerk:78]seq:14))
	
	
	$vbLaunch:=True:C214
	
Else 
	
	// TRY TO QUERY THE WEBCLERK RECORD MATCHING THE CURRENT MACHINE
	C_TEXT:C284($machineName)
	$machineName:=Current machine:C483
	// ### bj ### 20190806_1237
	READ ONLY:C145([WebClerk:78])
	QUERY:C277([WebClerk:78]; [WebClerk:78]machine:35=$machineName; *)
	QUERY:C277([WebClerk:78];  & ; [WebClerk:78]publish:7=1; *)
	QUERY:C277([WebClerk:78])
	
	// we should change this to a loop
	REDUCE SELECTION:C351([WebClerk:78]; 1)
	
	If (Records in selection:C76([WebClerk:78])=1)
		
		// ### JWM ### 20171016_1814 changed from Alert to ConsoleMessage
		ConsoleMessage("WebClerk Preferences For This Machine: \rMachine = "+String:C10([WebClerk:78]machine:35)+"\rPublish = "+String:C10([WebClerk:78]publish:7)+"\rSequence = "+String:C10([WebClerk:78]seq:14))
		
		$vbLaunch:=True:C214
		
	Else 
		
		QUERY:C277([WebClerk:78]; [WebClerk:78]publish:7=1; *)
		QUERY:C277([WebClerk:78];  & [WebClerk:78]seq:14=1)
		REDUCE SELECTION:C351([WebClerk:78]; 1)
		
		If (Records in selection:C76([WebClerk:78])=1)
			
			// ### JWM ### 20171016_1814 changed from Alert to ConsoleMessage
			ConsoleMessage("WebClerk Default Preferences: \rMachine = "+String:C10([WebClerk:78]machine:35)+"\rPublish = "+String:C10([WebClerk:78]publish:7)+"\rSequence = "+String:C10([WebClerk:78]seq:14))
			
			$vbLaunch:=True:C214
			
		Else 
			
			// ### JWM ### 20171016_1814 changed from Alert to ConsoleMessage
			ConsoleMessage("Error: Valid WebClerk Preferences Not Found WebClerk Server Launch Aborted")
			//ALERT("We couldn't find a valid preferences record, so we are aborting the WebClerk Server launch.")
			
			$vbLaunch:=False:C215
			
		End if 
		
	End if 
	
End if 

$0:=$vbLaunch