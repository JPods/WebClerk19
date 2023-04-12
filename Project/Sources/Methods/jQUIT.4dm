//%attributes = {"publishedWeb":true}
If (False:C215)
	//  jQuit
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 


///  zzzzz Add a graceful close
//  <>vbDoQuit
SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D software:K37:66)  // Enable Direct2D fixes message bug with Windows client

$viWidth:=Screen width:C187
$viHeight:=Screen height:C188

$viLeft:=$viWidth/2-200
$viRight:=$viWidth/2+200
$viTop:=$viHeight/2-100
$viBottom:=$viHeight/2+100

Open window:C153($viLeft; $viTop; $viRight; $viBottom; 8; "Shutting Down...")
ERASE WINDOW:C160
GOTO XY:C161(6; 3)
MESSAGE:C88("Closing Cronjob Manager...")
GOTO XY:C161(6; 5)
MESSAGE:C88("Quitting 4D...")

<>vCronLoop:=0
vifound:=1
While (vifound>0)
	vifound:=Prs_CheckRunnin("Cronjob Manager")
End while 

TRACE:C157
QUIT 4D:C291(1)

C_LONGINT:C283($k; $incRec)
$k:=60
//ThermoInitExit ("Closing";$k;True)
$viProgressID:=Progress New

For ($incRec; 1; $k)
	If ($incRec=1)
		//QUIT 4D(1)
	End if 
	//Thermo_Update ($incRec)
	ProgressUpdate($viProgressID; $incRec; $k; "Closing")
	DELAY PROCESS:C323(Current process:C322; 60)
End for 
//Thermo_Close 
Progress QUIT($viProgressID)

If (False:C215)
	KeyModifierCurrent
	If ((OptKey=1) & (cmdKey=1))
		QUIT 4D:C291
	Else 
		C_LONGINT:C283(<>viCancelClose)
		<>viCloseOK:=1
		If (<>viDelayQuit=-1)
			$k:=0
		Else 
			$k:=<>viDelayQuit
		End if 
		If (False:C215)
			//ThermoInitExit ("Click Stop to Cancel Closing";$k;True)
			$viProgressID:=Progress New
			For ($incRec; 1; $k)
				Thermo_Update($incRec)
				ProgressUpdate($viProgressID; $incRec; $k; "Click Stop to Cancel Closing")
				DELAY PROCESS:C323(Current process:C322; 60)
			End for 
			//Thermo_Close 
			Progress QUIT($viProgressID)
		End if 
		//CONFIRM("Quit CommerceExpert/WebClerk?")
		If (<>viCloseOK=1)
			<>viCloseOK:=0
			Process_ListActive
			//TRACE
			//
			C_LONGINT:C283($countProcesses; $appType)
			$appType:=Application type:C494
			
			$countProcesses:=3
			If ($appType=4)
				$countProcesses:=4
			End if 
			//
			C_LONGINT:C283($myCount; $i; $k; $w; $test; $incProcess)
			C_TEXT:C284($prcsName)
			C_LONGINT:C283($prcsNum)
			//<>vbDoQuit:=True
			//
			Process_ListActive
			QUIT 4D:C291
			//
			If (False:C215)
				$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")  //HTTP or HTTPS  
				If ($w>0)
					MESSAGE:C88("Closinging WebClerk Server Processes.")
					WC_StartUpShutDownFlip(0)
					DELAY PROCESS:C323(Current process:C322; 3600)
					// End if 
					If (False:C215)
						Process_ListActive
						$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")  //HTTP or HTTPS  
						If ($w>0)
							MESSAGE:C88("Closinging WebClerk Server Processes 2.")
							WC_StartUpShutDownFlip(0)
							DELAY PROCESS:C323(Current process:C322; 3600)
							//End if 
							Process_ListActive
							$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")  //HTTP or HTTPS  
							If ($w>0)
								MESSAGE:C88("Closinging WebClerk Server Processes 3.")
								WC_StartUpShutDownFlip(0)
								DELAY PROCESS:C323(Current process:C322; 3600)
							End if 
						End if 
					End if 
				End if 
				//
				Process_ListActive
				$k:=Size of array:C274(<>aPrsName)
				Case of 
					: (CmdKey=1)
						QUIT 4D:C291
					: ($k>3)
						CONFIRM:C162("Quit without individually closing processes.")
						If (OK=1)
							QUIT 4D:C291
						End if 
					Else 
						QUIT 4D:C291
				End case 
			End if 
		End if 
	End if 
End if 