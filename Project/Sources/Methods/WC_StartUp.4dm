//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-01T00:00:00, 19:14:54
// ----------------------------------------------------
// Method: WC_StartUp
// Description
// Modified: 09/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($vbLaunch)

// IF THE WEBCLERK SERVER IS ALREADY RUNNING, BRING THE STATUS WINDOW TO THE FRONT
If (Find in array:C230(<>aPrsNameWeb; "WC_@")>0)
	BRING TO FRONT:C326(<>webMonitorProcess)
	// ELSE, START THE SERVER
Else 
	
	$vbLaunch:=WC_LoadPrefsRecord
	
	
	If ($vbLaunch=True:C214)
		
		C_LONGINT:C283($webClerkRecordNum)
		$webClerkRecordNum:=Record number:C243([WebClerk:78])
		$startWebClerk:=1  // turn switch on
		
		// CHECK TO SEE IF THE jitWeb FOLDER IS VALID
		
		$vbLaunch:=WC_TestFolder
		
		// PROCEEED IF TRUE
		
		If ($vbLaunch=True:C214)
			
			ConsoleLog("Starting WebClerk Server: "+String:C10(Current date:C33)+": "+String:C10(Current time:C178))  // ### JWM ### 20171016_1823
			
			WC_LoadObjects  // queries [WebClerk]
			WC_MultiDomainSet
			// ### bj ### 20210822_1437   vResponse is now the default error message
			WC_ErrorPageMaster
			WC_VariablesDeclare
			
			<>dtStartWebClerk:=DateTime_DTTo
			ARRAY TEXT:C222(<>aWebPagePaths; 0)
			ARRAY TEXT:C222(<>aWebPages; 0)
			ARRAY LONGINT:C221(<>aWebPageSecurityLevel; 0)
			ARRAY LONGINT:C221(<>aWebPageTimesCalled; 0)
			ARRAY LONGINT:C221(<>aWebPageTimesSecurityFails; 0)
			
			C_BOOLEAN:C305(<>WccActive)  // clean up this into a single place and set of variables
			// Modified by: williamjames (110619)
			ARRAY TEXT:C222(<>aDebugWebLog; 0)
			
			
			C_LONGINT:C283($processID)
			//$inc:=1 // #### AZM #### 20171013_1423 - This was used one time, and hardcoded.
			//C_LONGINT(<>webEngine)  // What is this for QQQQQ  // #### AZM #### 20171013_1409 - I don't know but it's gone now.
			//<>webEngine:=1
			
			
			
			//$p:=New process("WC_Server";<>tcPrsMemory;"WebClerkProcesses"+String($inc);$webClerkRecordNum;*) // #### AZM #### 20171013_1423 - This was used one time, and hardcoded.
			$p:=New process:C317("WC_Server"; <>tcPrsMemory; "WebClerkProcesses1"; $webClerkRecordNum; *)
			REDUCE SELECTION:C351([WebClerk:78]; 0)
			
			WC_ShowMonitor
			// ### bj ### 20210202_2313
			If (False:C215)  // replace with Vue side behavior
				// ### bj ### 20200606_1118
				$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"ImagePathEmpty.jpg"
				If (Test path name:C476($vtPath)#1)
					ALERT:C41("Critical image missing: "+$vtPath)
					ConsoleLog("Critical image missing: "+$vtPath)
				End if 
				$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"ImagePathInvalid.jpg"
				If (Test path name:C476($vtPath)#1)
					ALERT:C41("Critical image missing: "+$vtPath)
					ConsoleLog("Critical image missing: "+$vtPath)
				End if 
			End if 
			<>prcControl:=0
			//End if 
			$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")
			If ($w>0)
				OBJECT SET ENABLED:C1123(b8; True:C214)
				OBJECT SET ENABLED:C1123(b7; False:C215)
				OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; Yellow:K11:2)
				
			Else 
				OBJECT SET ENABLED:C1123(b8; False:C215)
				OBJECT SET ENABLED:C1123(b7; True:C214)
				OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; White:K11:1)
			End if 
			
		End if 
		
	End if 
	
End if 