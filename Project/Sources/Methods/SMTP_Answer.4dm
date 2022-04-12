//%attributes = {"publishedWeb":true}

// Procedure: SMTP_Answer
// wait for answer from SMTP server
// $1 -> stream TCP
// $0 <- 1 = ok, -1 = Err
C_LONGINT:C283($1; $serverThread; $0)
C_TEXT:C284($buff; $temp)
C_TEXT:C284($2)
C_BOOLEAN:C305(vbDoEventLog)

$serverThread:=$1
$0:=0
vtEmailMessageLog:=vtEmailMessageLog+"\r"+"C: "+$2
vtEmailMessage:=vtEmailMessage+"\r"+"C:  No Thread"
If ($serverThread#0)
	If ($2#"")  //passing "" procedure can be used to just receive
		$err:=TCP Send($serverThread; $2)  // log on SMTP host
		ConsoleMessage(">> \r"+$2)
		vtEmailMessage:="\r"+"C: "+$2
		
		$buff:="\n"
		C_LONGINT:C283($timeOutTicks; $result; $endServer; $delayTicks)
		$timeOutTicks:=Tickcount:C458+(60*<>vlWebTimeOutDelay)
		$delayTicks:=Tickcount:C458+(60*5)
		DELAY PROCESS:C323(Current process:C322; 10)
		Repeat 
			$result:=TCP Receive($serverThread; $temp)
			
			$buff:=$buff+$temp
			Case of 
				: (Position:C15(Char:C90(10)+"2"; $buff)>0)
					$0:=2
				: (Position:C15(Char:C90(10)+"3"; $buff)>0)
					$0:=3
				: (Position:C15(Char:C90(10)+"5"; $buff)>0)
					$0:=-5
				: ($timeOutTicks<Tickcount:C458)
					$0:=-10
			End case 
			IDLE:C311
			$endServer:=Position:C15(Storage:C1525.char.crlf+Storage:C1525.char.crlf; $buff)  //+Num(<>vbWCstop)
		Until (($0#0) | (<>vbWCstop))
		
		ConsoleMessage("<<"+$buff)
		
		If ($buff=Char:C90(9))
			vtEmailMessageLog:=vtEmailMessageLog+"S:  No response, Result="+String:C10($result)+"\r"
			vtEmailMessage:="No response, Result"
		Else 
			
			vtEmailMessage:=Substring:C12($buff; 2)
			If (vtEmailMessage="2@")
				vtEmailStatusMessage:="verified"
			End if 
			vtEmailMessageLog:=vtEmailMessageLog+"\r"+"S: "+vtEmailMessage
			
		End if 
	Else 
		vtEmailMessageLog:=vtEmailMessageLog+"\r"+"C: No Action Passed"
		vtEmailMessage:="\r"+"C: No Action Passed"
	End if 
Else 
	vtEmailMessageLog:=vtEmailMessageLog+"C: No Thread"+"\r"
	vtEmailMessage:="C: No Thread"
End if 


