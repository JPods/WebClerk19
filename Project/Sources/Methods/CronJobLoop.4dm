//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/07/12, 08:31:41
// ----------------------------------------------------
// Method: CronJobLoop
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20161207_1003 Only one instance allowed


If (Application type:C494#4D Server:K5:6)  // ### jwm ### 20190228_0906 do not run on server
	
	If (False:C215)
		$processName:="Name1"
		$theScript:="Alert("+Txt_Quoted("Hello World.")+")"
		$avoidConfirm:=0
		$childProcess:=New process:C317("ExecuteText"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$processName; $avoidConfirm; $theScript)  //;$1)
		//$childProcess:=New process("ExecuteText";<>tcPrsMemory;String(Count user processes)+"-"+[TimedEvent]EventName;$avoidConfirm;[TimedEvent]Script)//;$1)
	End if 
	
	C_TIME:C306($vhNow)
	C_LONGINT:C283($viSeconds; $viDelay)
	C_BOOLEAN:C305($bRunEvent)
	
	
	SET WINDOW RECT:C444(-1; -1; 0; 0)
	<>vCronLoop:=1
	$vhNow:=Current time:C178  //current time
	$viSeconds:=$vhNow%60  //seconds past the current minute
	$viDelay:=60-$viSeconds  //seconds to delay until the next minute   //### jwm ### 20120924_1115
	
	While (<>vCronLoop>0)
		
		$dtDueNow:=DateTime_Enter+$viDelay
		
		If (Application type:C494=4D Server:K5:6)
			QUERY:C277([CronJob:82]; [CronJob:82]runOnServer:18=True:C214; *)
			QUERY:C277([CronJob:82];  | ; [CronJob:82]nameID:10="OnServer"; *)
			QUERY:C277([CronJob:82];  & ; [CronJob:82]active:12=True:C214; *)
			QUERY:C277([CronJob:82])
		Else 
			
			//### jwm ### 20120924_1105 Begin
			If (False:C215)
				C_TEXT:C284($currentUser)
				$currentUser:=Current user:C182
				QUERY:C277([CronJob:82]; [CronJob:82]machineName:22=<>machineName; *)
				QUERY:C277([CronJob:82];  | ; [CronJob:82]machineName:22="All Machine@"; *)
				QUERY:C277([CronJob:82];  | ; [CronJob:82]nameID:10=$currentUser; *)
				QUERY:C277([CronJob:82];  | ; [CronJob:82]nameID:10="All User@"; *)
				QUERY:C277([CronJob:82];  & ; [CronJob:82]active:12=True:C214; *)
				QUERY:C277([CronJob:82])
				
			Else 
				// ### jwm ### 20171030_1329  allows wild card @ in fields nameID and MachineName
				QUERY BY FORMULA:C48\
					([CronJob:82]; (Current machine:C483=[CronJob:82]machineName:22)\
					 | ([CronJob:82]machineName:22="All Machines")\
					 | (Current user:C182=[CronJob:82]nameID:10)\
					 | ([CronJob:82]nameID:10="All Users")\
					 & ([CronJob:82]active:12=True:C214))
			End if 
			
		End if 
		
		$k:=Records in selection:C76([CronJob:82])
		FIRST RECORD:C50([CronJob:82])
		C_LONGINT:C283($dtEvent)
		FIRST RECORD:C50([CronJob:82])
		For ($i; 1; $k)
			//### jwm ### 20120924_1111 Begin
			$bRunEvent:=False:C215
			
			Case of 
				: ((Current user:C182=[CronJob:82]nameID:10) & (Current machine:C483=[CronJob:82]machineName:22))
					$bRunEvent:=True:C214
					
				: (([CronJob:82]nameID:10="All Users") & ([CronJob:82]machineName:22="All Machines"))
					$bRunEvent:=True:C214
					
				: ((Current user:C182=[CronJob:82]nameID:10) & ([CronJob:82]machineName:22="All Machines"))
					$bRunEvent:=True:C214
					
				: (([CronJob:82]nameID:10="All Users") & (Current machine:C483=[CronJob:82]machineName:22))
					$bRunEvent:=True:C214
					
			End case 
			
			If ($bRunEvent)
				C_LONGINT:C283($error)
				
				vifound:=Prs_CheckRunnin([CronJob:82]eventName:15)
				If (([CronJob:82]multipleThread:16=False:C215) & (vifound>0))
					// ### jwm ### 20161207_1003 Only one instance allowed
					$error:=0
				Else 
					$error:=CronJobExecute
				End if 
				
				//[TimedEvent]Active:=True
				//SAVE RECORD([TimedEvent])
				If ($error=1)
					//[CronJob]DTLast:=$dtDueNow
					//SAVE RECORD([CronJob])
				End if 
			End if 
			
			
			NEXT RECORD:C51([CronJob:82])
		End for 
		UNLOAD RECORD:C212([CronJob:82])  //### jwm ### 20120924_1141
		
		// Calculate Next Minute
		$vhNow:=Current time:C178  //current time
		$viSeconds:=$vhNow%60  //seconds past the current minute
		$viDelay:=60-$viSeconds  //seconds to delay until the next minute   //### jwm ### 20120924_1115
		$vtThen:="00:00:"+String:C10($viDelay; "00")
		$vhNext:=$vhNow+Time:C179($vtThen)
		
		// Timing Loop checks once a second for Next event and Shutdown
		While ((<>vCronLoop>0) & ($vhNext>$vhNow))
			$vhNow:=Current time:C178  //current time
			DELAY PROCESS:C323(Current process:C322; 60)  //60 ticks 1 second delay
		End while 
		
	End while 
	
	If (False:C215)
		$doNotDoThis:=1
		If ($doNotDoThis=1)
			If ($bRunEvent)
				If (([CronJob:82]dtNextEvent:20+([CronJob:82]displayOptions:29*60)+$viSeconds)<$dtDueNow)  //Next + tolerance is less than now.
					$bRunEvent:=False:C215
				End if 
				$dtEvent:=CronDTNext([CronJob:82]cronString:28)  //calculate if there is a future event.
				If ($bRunEvent)
					C_LONGINT:C283($i; $k; $w; $childProcess; $avoidConfirm)
					C_TEXT:C284($packedvariables)
					$childProcess:=New process:C317("ExecuteTextInNewProcess"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+[CronJob:82]eventName:15; [CronJob:82]script:11; [CronJob:82]scriptAfter:25; $packedvariables)  //;$1)
					[CronJob:82]dtLast:14:=$dtDueNow
				End if 
				If ($dtEvent<$dtDueNow)  //no future event calculated.
					//[TimedEvent]Active:=False
					// zzzqqq jDateTimeStamp(->[CronJob:82]comment:23; "Deactivated because this event has no future.")
				End if 
				//[CronJob]DTNextEvent:=$dtEvent
				//SAVE RECORD([CronJob])
				//### jwm ### 20120924_1111 End
			End if 
		End if 
	End if 
	
	
	
End if 
