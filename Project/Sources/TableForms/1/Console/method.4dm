
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/07/17, 14:02:21
// ----------------------------------------------------
// Method: [Control].Console
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($formEvent; viTopToBottom; $length; $limit)
$formEvent:=Form event code:C388
C_TEXT:C284(<>vConsoleMessage; vMessage)
$limit:=100000  // 100K characters  changed from 100M to 100K per NUG 
// ### jwm ### 20180101_0143 1 million characters
// ### jwm ### 20170316_1354 test 10K characters
Case of 
		
	: ($formEvent=On Load:K2:1)
		ARRAY TEXT:C222(iLoaText1; 0)
		APPEND TO ARRAY:C911(iLoaText1; "NewAtTop")
		APPEND TO ARRAY:C911(iLoaText1; "NewAtBottom")
		APPEND TO ARRAY:C911(iLoaText1; "Replace")
		APPEND TO ARRAY:C911(iLoaText1; "Off")
		If (<>consoleDirection=0)
			<>consoleDirection:=2
		End if 
		iLoaText1:=<>consoleDirection
		vMessage:=""
	: (Outside call:C328)
		//  vNewThermoTitle
		//update thermometer and set vNewThermoCount:=-1 to ack call    
		Case of 
			: (<>vbDoQuit)
				CANCEL:C270
			: (Size of array:C274(<>atConsoleMessage)>0)  // ### jwm ### 20160711_1333 console messages in buffer
				
				If (Not:C34(Semaphore:C143("$ConsoleBusy"; 300)))  // wait 5 seconds if array is busy, set busy when ready
					Case of 
						: (<>atConsoleMessage{1}="ConsoleClose")
							CANCEL:C270
						: (iLoaText1=1)  // new at top
							Repeat 
								vMessage:=<>atConsoleMessage{1}+"\r"+vMessage
								DELETE FROM ARRAY:C228(<>atConsoleMessage; 1; 1)
							Until (Size of array:C274(<>atConsoleMessage)=0)
							
							// ### jwm ### 20170207_1354 limit size of text protect against overflow
							$length:=Length:C16(vmessage)
							If ($length>$limit)
								vMessage:=Substring:C12(vMessage; 1; $limit)  // get first characters up to limit
							End if 
							
						: (iLoaText1=2)  // new at bottom
							Repeat 
								vMessage:=vMessage+"\r"+<>atConsoleMessage{1}
								$viPos:=Length:C16(vMessage)+1
								HIGHLIGHT TEXT:C210(vMessage; $viPos; $viPos)  // put cursor at end // ### jwm ### 20160912_2113
								// ### bj ### 20200122_1335
								If (Size of array:C274(<>atConsoleMessage)>0)
									DELETE FROM ARRAY:C228(<>atConsoleMessage; 1; 1)
								End if 
							Until (Size of array:C274(<>atConsoleMessage)=0)
							
							// ### jwm ### 20170207_1354 limit size of text protect against overflow
							$length:=Length:C16(vmessage)
							If ($length>$limit)
								vMessage:=Substring:C12(vMessage; ($length-$limit))  // get last characters up to limit
							End if 
							
						: (iLoaText1=3)  // replace
							Repeat 
								vMessage:=<>atConsoleMessage{1}
								DELETE FROM ARRAY:C228(<>atConsoleMessage; 1; 1)
							Until (Size of array:C274(<>atConsoleMessage)=0)
						Else 
							vMessage:=""
					End case 
					CLEAR SEMAPHORE:C144("$ConsoleBusy")  // clear busy status
					
				End if 
				
		End case 
		
	: (<>vConsoleMessage#"")  //change the Thermo message on the fly
		Case of 
			: (<>vConsoleMessage="ConsoleClose")
				CANCEL:C270
			: (iLoaText1=1)  // at top
				vMessage:=<>vConsoleMessage+"\r"+vMessage
			: (iLoaText1=2)  // at bottom
				vMessage:=vMessage+"\r"+<>vConsoleMessage
			: (iLoaText1=3)  // replace
				vMessage:=<>vConsoleMessage
			Else 
				vMessage:=""
		End case 
		<>vConsoleMessage:=""
		If (False:C215)  // put to bypass <>ThermoAbort not being set to false
			Case of 
				: (<>ThermoAbort)
					CANCEL:C270
					vNewThermometer:=-1
				: (vNewThermometer=-2)
					CANCEL:C270
					vNewThermometer:=-1
				Else 
					//Thermometer:=(vNewThermoCount*100)/vNewThermoTotal
					Thermometer:=vNewThermometer
					vNewThermometer:=-1
			End case 
		End if 
End case 

