//%attributes = {"publishedWeb":true}
//Procedure: CC_ZonGetText
//Procedure polls the serial port
If (False:C215)
	C_TEXT:C284(<>vtZonJrText; $ZonJrText)  //accumulated serial input
	SET CHANNEL:C77(<>ZonRcvPort; <>ciZonRcvCom)  //9600 7E2
	SET TIMEOUT:C268(5)  //set the length of the system error for timeout
	<>vtZonJrText:=""
	While (<>ZonRcvRun)
		RECEIVE BUFFER:C172($ZonJrText)
		If ($ZonJrText#"")
			C_LONGINT:C283($End)
			C_TEXT:C284($inComing)  //max size of buffer is 64 char, overflow is lost
			$End:=Tickcount:C458+20  // wait for 30/60th of a sec for any more data
			Repeat 
				RECEIVE BUFFER:C172($inComing)  //unload the serial buffer
				If ($inComing#"")
					$ZonJrText:=$ZonJrText+$inComing  //accumulate the serial input      
					$End:=Tickcount:C458+20  //reset Time Out Counter; wait for 30/60th of a sec for any more data
				End if 
			Until (Tickcount:C458>$End)  //Time out
			<>vtZonJrText:=<>vtZonJrText+$ZonJrText
			POST OUTSIDE CALL:C329(<>UserRunPrcs)  //trigger outside call for main process
			PAUSE PROCESS:C319(Current process:C322)
		End if 
	End while 
	<>vtZonJrText:=""
End if 