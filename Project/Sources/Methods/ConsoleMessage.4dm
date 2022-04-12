//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-22T00:00:00, 08:49:37
// ----------------------------------------------------
// Method: ConsoleMessage
// Description
// Modified: 12/22/15
// Structure: CEv13_131005
// 
//
// Parameters: $1 = message; $2 = direction
// ----------------------------------------------------

If (False:C215)
	ConsoleMessage("111111")
	ConsoleMessage("222222")
	ConsoleMessage("333333")
End if 
//  ConsoleMessage("ConsoleClose")
//  ConsoleMessage("ConsoleLaunch")
C_TEXT:C284($1; $message)
C_LONGINT:C283(<>consoleDirection; $found; <>consoleProcess)
C_LONGINT:C283($messageDirection; $2)
C_LONGINT:C283(<>consoleMax)

$message:=$1

If (Application type:C494#4D Server:K5:6)  // ### jwm ### 20190227_1732
	
	Case of 
		: (($1="ConsoleLaunch") | ($1="Launch"))  // call to launch the Console   // ### jwm ### 20171017_2246 needs to be an exact match 
			ConsoleLaunch  // ### jwm ### 20180605_2043 consoleLaunch checks for Process Console
			
		: (<>consoleDirection=0)  // Console is not active, so do not try to send it messages other than ConsoleLaunch
			
		Else   // take the time to send a message
			//$found:=Prs_CheckRunnin ("Console@")  // ### jwm ### 20160513_0958 average of 500 milliseconds to run
			$found:=1  // ### jwm ### 20160512_1711 always run
			If ($found>0)
				If (Count parameters:C259>1)
					If ($2>0)
						<>consoleDirection:=$2
					End if 
				End if 
				
				If (False:C215)  //false = use arrays
					Case of 
						: (<>consoleDirection=1)  // append
							<>vConsoleMessage:=$1+<>vConsoleMessage
						: (<>consoleDirection=2)  // insert at top
							<>vConsoleMessage:=<>vConsoleMessage+$1
						: (<>consoleDirection=3)  // replace
							<>vConsoleMessage:=$1
					End case 
					
				Else 
					
					If (Not:C34(Semaphore:C143("$ConsoleBusy"; 300)))  // wait 5 seconds if array is busy, set busy when ready
						APPEND TO ARRAY:C911(<>atConsoleMessage; $1)
						C_LONGINT:C283($inc; $cnt; <>viMaxConsoleArray)
						If (<>viMaxConsoleArray=0)
							<>viMaxConsoleArray:=Num:C11(DefaultSetupsReturnValue("<>viMaxConsoleArray"))
							If (<>viMaxConsoleArray=0)
								<>viMaxConsoleArray:=300
							End if 
						End if 
						$cnt:=Size of array:C274(<>atConsoleMessage)
						If ($cnt><>viMaxConsoleArray)
							$cnt:=$cnt-<>viMaxConsoleArray
							DELETE FROM ARRAY:C228(<>atConsoleMessage; 1; $cnt)
						End if 
						CLEAR SEMAPHORE:C144("$ConsoleBusy")
					End if 
					
				End if 
				POST OUTSIDE CALL:C329(<>consoleProcess)
				//DELAY PROCESS(Current process;1)  // ### jwm ### 20160513_0957
			End if 
	End case 
	
	
End if 
