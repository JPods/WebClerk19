

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
// ### jwm ### 20190828_1559 added date time stamp to span midnight 23:59 will always be greater than 00:00

C_LONGINT:C283($viDelay; $viSeconds; vifound; viLine; $viNext; $viNow; $viThen)
C_TEXT:C284($vtThen; vtCurrentTime; vtStatus)
C_TIME:C306(vhNext; vhNow)
C_BOOLEAN:C305(vbShow)



Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		
		
		If (UserInPassWordGroup("AdminControl"))
			CONFIRM:C162("Hide or Shutdown CronJob Manager"; "Hide"; "Shutdown")
			
			If (OK=1)
				vbShow:=False:C215
				HIDE PROCESS:C324(Current process:C322)
			Else 
				// shutdown CronJob Manager
				<>vCronLoop:=0
			End if 
			
		Else 
			vbShow:=False:C215
			HIDE PROCESS:C324(Current process:C322)
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		vbShow:=False:C215
		vtStatus:=""
		vtUser:=Current user:C182
		vtMachine:=Current machine:C483
		viRecords:=Records in selection:C76([CronJob:82])
		var eSel; LB_CronJobdata : Object
		eSel:=ds:C1482.CronJob.all()
		Form:C1466.LB_CronJob.data:=ds:C1482.CronJob.all()
		// -- AL_SetAreaLongProperty(ecronjobs; ALP_Area_Compatibility; 0)
		
		SET TIMER:C645(60)  // one second
		
		C_TIME:C306(vhNow)
		C_LONGINT:C283($viSeconds; $viDelay)
		C_BOOLEAN:C305($bRunEvent)
		
		//SET WINDOW RECT(-1;-1;0;0)
		<>vCronLoop:=1
		
		// Calculate Next Minute on start
		vhNow:=Current time:C178  //current time
		$viSeconds:=vhNow%60  //seconds past the current minute
		$viDelay:=60-$viSeconds  //seconds to delay until the next minute   //### jwm ### 20120924_1115
		//$viNow:=DateTime_Enter (Current date;vhNow)
		//$viNext:=$viNow+$viDelay
		//vhNext:=jDateTimeRTime ($viNext)
		$vtThen:="00:00:"+String:C10($viDelay; "00")
		vhNext:=vhNow+Time:C179($vtThen)
		
		
	: (Form event code:C388=On Timer:K2:25)
		//TRACE
		// set to zero on Quit
		If ((<>vCronLoop=0))
			CANCEL:C270
		End if 
		
		// update all valid cronjobs for Current User and Machine
		//Get_Cronjobs
		//SetListLine(viLine)
		////  --  CHOPPED  AL_UpdateArrays(eCronJobs; -2)
		
		viRecords:=Records in selection:C76([CronJob:82])
		vtUser:=Current user:C182
		vtMachine:=Current machine:C483
		vhNow:=Current time:C178  //current time
		
		// at midnight reset vhNext to 00:00:00 to keep timing comparison correct
		If (vhNow=?00:00:00?)
			vhNext:=?00:00:00?
		End if 
		
		// if vhNext is 24:00 any time other than 23:59 - 24:00 reset to 00:00 to keep timing comparison correct
		If ((vhNext>=?24:00:00?) & (vhNow>=?00:00:00?) & (vhNow<=?23:59:00?))
			vhNext:=?00:00:00?
		End if 
		
		vtCurrentTime:=String:C10(vhNow; HH MM SS:K7:1)
		vtNextTime:=String:C10(vhNext; HH MM SS:K7:1)
		REDRAW WINDOW:C456
		
		// Timing Loop checks once a second for Next event and Shutdown
		If ((<>vCronLoop>0) & (vhNext<=vhNow))
			
			// Calculate Next Minute when last minute has past
			vhNow:=Current time:C178  //current time
			$viSeconds:=vhNow%60  //seconds past the current minute
			$viDelay:=60-$viSeconds  //seconds to delay until the next minute   //### jwm ### 20120924_1115
			//$viNow:=DateTime_Enter (Current date;vhNow)
			//$viNext:=$viNow+$viDelay
			//vhNext:=jDateTimeRTime ($viNext)
			
			$vtThen:="00:00:"+String:C10($viDelay; "00")
			vhNext:=vhNow+Time:C179($vtThen)
			
			
			If (Application type:C494#4D Server:K5:6)  // ### jwm ### 20190228_0906 do not run on server
				
				// open new process to loop through CronJobs
				// ### jwm ### 20190826_1129 un ique Process Name for CronLoop
				var $cronProcess : Integer
				$cronProcess:=New process:C317("Prs_CronLoop"; 0; "CronLoop"+"-"+String:C10(Count user processes:C343))
				
			End if   // not 4D Server
			
			
		End if   // execute cronjob and check Time
		
End case 