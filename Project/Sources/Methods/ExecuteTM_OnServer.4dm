//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-31T00:00:00, 18:18:17
// ----------------------------------------------------
// Method: Execute_OnServer
// Description
// Modified: 07/31/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tallyName; $2; $tallyPurpose)
$tallyName:=$1
$tallyPurpose:=$2
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$1; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$2; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)

//  QUERY([TallyMaster]; & [TallyMaster]Publish>0)
//  QUERY([TallyMaster]; &[TallyMaster]Publish<=viEndUserSecurityLevel)
ConsoleLog("Launch")
Case of 
	: (Records in selection:C76([TallyMaster:60])=0)
		ConsoleLog("No TallyMaster Name: "+$1+", Purpose: "+$2)
	: (Records in selection:C76([TallyMaster:60])>1)
		ConsoleLog("Multiple TallyMaster Name: "+$1+", Purpose: "+$2)
	Else 
		C_TEXT:C284($tallyPreScript; $tallyProcessScript; $tallyPostScript)
		C_LONGINT:C283(vlserverCount; vlserverIncrement; vlserverProcessID; vlAbsoluteprocessID; $timeOut; $timeCounter; $timeEndTics)
		// use to pass to the thermo
		C_TEXT:C284(vtserverStatus)
		vtserverStatus:=""
		vlserverCount:=0
		vlserverIncrement:=0
		C_LONGINT:C283(vlserverReady)  // 0 nothing, 1 ready, 2 inprocess, 3 complete
		vlserverCount:=vlserverIncrement
		// the server starts at not ready 0
		// the server process launched and  ready 1
		// the server process running 2
		// the server process complete 3
		vtServerTitle:=$tallyName
		$tallyPreScript:=[TallyMaster:60]script:9
		$tallyProcessScript:=[TallyMaster:60]build:6
		$tallyPostScript:=[TallyMaster:60]after:7
		$timeOut:=Num:C11([TallyMaster:60]realName1:16)
		If ($timeOut<100)
			$timeOut:=30*60*1000  // in milliseconds, 15 minutes
		End if 
		
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		
		ConsoleLog("Initiating ServerSide: "+$1+", Purpose: "+$2)
		
		vlserverProcessID:=Execute on server:C373("ExecuteText"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-OnServer"; 0; [TallyMaster:60]build:6; *)
		vlAbsoluteprocessID:=Abs:C99(vlserverProcess)
		
		ConsoleLog("SSProcess: "+String:C10(vlserverProcessID))
		
		$timeEndTics:=Milliseconds:C459+$timeOut
		
		While ((vlserverReady=0) & ($timeEndTics<Milliseconds:C459))  //timeout = 1/2 hour
			DELAY PROCESS:C323(Current process:C322; 6)
			GET PROCESS VARIABLE:C371(vlserverProcessID; vlserverReady; vlserverReady; vtserverStatus; vtserverStatus; vtServerTitle; vtServerTitle)
			If (vtserverStatus#"")
				ConsoleLog($tallyName+": "+vtserverStatus)
			End if 
		End while 
		
End case 