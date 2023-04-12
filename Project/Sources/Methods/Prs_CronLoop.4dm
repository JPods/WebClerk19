//%attributes = {}

//TRACE
C_TIME:C306($vhNow; $vhNext)
C_LONGINT:C283($viSeconds; $viDelay; $i; $k; viLine; viProcessNum)
C_TEXT:C284($vtThen; vtStatus)
C_BOOLEAN:C305($bRunEvent)

viProcessNum:=Process number:C372("CronManager")
GET PROCESS VARIABLE:C371(viProcessNum; vbShow; vbShow)
//TRACE
If (vbShow)
	SHOW PROCESS:C325(viProcessNum)
	SET PROCESS VARIABLE:C370(viProcessNum; vtStatus; "Running...")
	POST OUTSIDE CALL:C329(viProcessNum)
Else 
	HIDE PROCESS:C324(viProcessNum)
End if 

// Calculate Next Minute on start
$vhNow:=Current time:C178  //current time
$viSeconds:=$vhNow%60  //seconds past the current minute
$viDelay:=60-$viSeconds  //seconds to delay until the next minute   //### jwm ### 20120924_1115
$vtThen:="00:00:"+String:C10($viDelay; "00")
$vhNext:=$vhNow+Time:C179($vtThen)

$dtDueNow:=DateTime_DTTo+$viDelay

// get all valid cronjobs for Current User and Machine
Get_Cronjobs

$k:=Records in selection:C76([CronJob:82])
FIRST RECORD:C50([CronJob:82])
C_LONGINT:C283($dtEvent)
FIRST RECORD:C50([CronJob:82])
For ($i; 1; $k)
	
	If (vbShow)
		SET PROCESS VARIABLE:C370(viProcessNum; viLine; Num:C11($i))
		POST OUTSIDE CALL:C329(viProcessNum)
	End if 
	
	C_LONGINT:C283($error)
	
	vifound:=Prs_CheckRunnin([CronJob:82]eventName:15)
	If (([CronJob:82]multipleThread:16=False:C215) & (vifound>0))
		// ### jwm ### 20161207_1003 Only one instance allowed
		$error:=0
	Else 
		$error:=CronJobExecute
	End if 
	
	If ($error=1)
		//[CronJob]DTLast:=$dtDueNow
		//SAVE RECORD([CronJob])
	End if 
	
	NEXT RECORD:C51([CronJob:82])
End for 
UNLOAD RECORD:C212([CronJob:82])  //### jwm ### 20120924_1141

SET PROCESS VARIABLE:C370(viProcessNum; viLine; 0)
POST OUTSIDE CALL:C329(viProcessNum)

GET PROCESS VARIABLE:C371(viProcessNum; vbShow; vbShow)
If (vbShow)
	SHOW PROCESS:C325(viProcessNum)
	SET PROCESS VARIABLE:C370(viProcessNum; vtStatus; "")
	POST OUTSIDE CALL:C329(viProcessNum)
Else 
	HIDE PROCESS:C324(viProcessNum)
End if 