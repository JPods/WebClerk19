//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $dtCutoff; $theRec; $hitCnt; $1; $OptKey)
TRACE:C157
If (Count parameters:C259=1)
	OK:=1
	$OptKey:=0
Else 
	KeyModifierCurrent
	CONFIRM:C162("Tally EventLogs to RemoteUsers and delete details.")
	$OptKey:=OptKey
End if 
If (OK=1)
	If ($OptKey=1)
		QUERY:C277([EventLog:75])
	Else 
		$dtCutoff:=DateTime_Enter(Current date:C33-1)
		QUERY:C277([EventLog:75]; [EventLog:75]dtEvent:1<=$dtCutoff; *)
		QUERY:C277([EventLog:75];  & [EventLog:75]groupid:3="netOrd")
	End if 
	$k:=Records in selection:C76([EventLog:75])
	ORDER BY:C49([EventLog:75]; [EventLog:75]remoteUserRec:10)
	$theRec:=-2
	$hitCnt:=0
	REDUCE SELECTION:C351([RemoteUser:57]; 0)
	FIRST RECORD:C50([EventLog:75])
	For ($i; 1; $k)
		If ([EventLog:75]groupid:3="webClerk")
			LOAD RECORD:C52([EventLog:75])
			If (Not:C34(Locked:C147([EventLog:75])))
				If ([EventLog:75]remoteUserRec:10#$theRec)
					[RemoteUser:57]hitCount:12:=[RemoteUser:57]hitCount:12+$hitCnt
					SAVE RECORD:C53([RemoteUser:57])
					GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
					$theRec:=[EventLog:75]remoteUserRec:10
					If ($theRec=-1)
						QUERY:C277([RemoteUser:57]; [RemoteUser:57]idEventLog:13="tallyLog")
						If (Records in selection:C76([RemoteUser:57])=0)
							CREATE RECORD:C68([RemoteUser:57])
							[RemoteUser:57]dateCreated:30:=Current date:C33
							
							[RemoteUser:57]idEventLog:13:=-5  //"tallyLog"
							[RemoteUser:57]customerID:10:="anon"
							SAVE RECORD:C53([RemoteUser:57])
						End if 
					End if 
					$hitCnt:=0
				End if 
				$hitCnt:=$hitCnt+[EventLog:75]hitsTotal:11
				
				
				// Modified by: Bill James (2017-04-27T00:00:00)
				
				
				[EventLog:75]groupid:3:=-5
				
				SAVE RECORD:C53([EventLog:75])
			End if 
		End if 
		NEXT RECORD:C51([EventLog:75])
	End for 
End if 
If (CmdKey=0)
	QUERY:C277([EventLog:75]; [EventLog:75]idNum:5="tallyLog")
	DELETE SELECTION:C66([EventLog:75])
End if 