//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/12/21, 08:18:41
// ----------------------------------------------------
// Method: LaunchShareDrive
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20210731_0618
// I was looping this a couple of times so a drive could be turned on that was off but that seems too complicated. 
// consider other options for mounting the drive 
//  // QQQXXX designator of something to work on

C_TEXT:C284($1; $driveLaunch; $vtProcess)
var $i : Integer
Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		ConsoleLog("driveLaunch: "+$driveLaunch)
		$driveLaunch:=$1
		$vtProcess:="new"
		$i:=New process:C317(Current method name:C684; 0; "LaunchServer: "+$driveLaunch; $driveLaunch; $vtProcess)
		//$i:=New process("LaunchShareDrive"; 0; "LaunchServer: "+$driveLaunch;$driveLaunch;$vtProcess)
	: (Count parameters:C259=2)
		//If (Is macOS)
		//$driveLaunch:="//192.168.1.16/ShareBillPC"
		//Else 
		//$driveLaunch:="\\\\192.168.1.16\\ShareBillPC"
		//End if 
		
		// Modified by: Bill James (2022-07-15T05:00:00Z)
		
		var $useSystemWorker : Boolean
		$useSystemWorker:=True:C214
		C_LONGINT:C283($viCnt)  // look at adding more attempts
		Repeat 
			$viCnt:=$viCnt+1
			If (Is macOS:C1572)
				// mount volume smb://[domain];[username]:[password]@[server]/[share]
				$externalPath:="osascript -e 'tell application \"Finder\""+"\r"+" mount volume \"smb:"+$driveLaunch+"\""+"\r"+" end tell'"
				If ($useSystemWorker)
					$sw:=4D:C1709.SystemWorker.new($externalPath)
				Else 
					LAUNCH EXTERNAL PROCESS:C811($externalPath)
				End if 
				DELAY PROCESS:C323(Current process:C322; 10)
			Else 
				// ### bj ### 20210612_0834  NOT TESTED
				//  net use \\Server\ShareName\Directory
				$externalPath:="cmd.exe net use "+$driveLaunch
				If ($useSystemWorker)
					$sw:=4D:C1709.SystemWorker.new($externalPath; \
						New object:C1471("hideWindow"; False:C215))
				Else 
					LAUNCH EXTERNAL PROCESS:C811($externalPath)
				End if 
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
			
			If (Test path name:C476($driveLaunch)=0)
				$pathResult_t:="available"
			Else 
				$pathResult_t:="offLine"
			End if 
			ConsoleLog("driveLaunch: "+$driveLaunch+"\r serverComEx results: "+$pathResult_t)
			
		Until ((Test path name:C476($driveLaunch)=0) | ($viCnt>0))
		
		
		
End case 