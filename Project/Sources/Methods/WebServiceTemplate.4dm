//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-16T00:00:00, 00:24:27
// ----------------------------------------------------
// Method: SyncUPS
// Description
// Modified: 09/16/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tallyName)
C_TEXT:C284($script; $build; $after; $template)
If (Count parameters:C259>0)
	$tallyName:=$1
Else 
	$tallyName:="TimeInTransitUPS"
End if 
HTTPSendText:=""
// Pull together some data
QUERY:C277([TallyMaster:60]; [TallyMaster:60]Name:8=$tallyName; *)  // is a template, not a procedure
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]Purpose:3="WebService"; *)
QUERY:C277([TallyMaster:60])
If (Records in selection:C76([TallyMaster:60])=1)
	If ([TallyMaster:60]Script:9#"")
		$script:=[TallyMaster:60]Script:9
		$build:=[TallyMaster:60]Build:6
		$after:=[TallyMaster:60]After:7
		$template:=[TallyMaster:60]Template:29
		// must fill variable as ExecuteText will unload TallyMasters
		
		// build variable in scripts HTTPSendText or pass it "" to have it built in WebServiceSynRelationCall
		If ($script#"")
			ExecuteText(0; $script)
		End if 
		If ($build#"")
			ExecuteText(0; $build)
		End if 
		
		WebServiceSynRelationCall([TallyMaster:60]Name:8; HTTPSendText)
		
		If ($after#"")
			// act on text in HTTPClient_Response
			ExecuteText(0; $after)
		End if 
	End if 
End if 