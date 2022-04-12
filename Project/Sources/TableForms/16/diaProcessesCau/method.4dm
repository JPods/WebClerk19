C_POINTER:C301($ptRay; $ptFile; $ptField; $ptSequence; $ptCode)
C_TEXT:C284(v1s50; v2s50)
C_LONGINT:C283($s)
Case of 
	: (Before:C29)
		MESSAGES OFF:C175
		ALL RECORDS:C47([QQQProcess:16])
		ORDER BY:C49([QQQProcess:16]; [QQQProcess:16]SequenceNum:1)
		
		
		//  ?????? FixThis
		SELECTION TO ARRAY:C260([QQQProcess:16]Process:2; <>aProcesses; [QQQProcess:16]idUnique:4; <>aProcessNums)
		ARRAY TEXT:C222(aAttributes; 0)
		//    array TEXT(aAttCodes;0)
		ARRAY TEXT:C222(aCauses; 0)
		<>aProcesses:=0
		b1:=1
		MESSAGES ON:C181
		
	Else 
		
		If ((b20=1) | (b21=1) | (b22=1) | (b23=1))
			MESSAGES OFF:C175
			Case of 
				: (((b2=0) & (b3=0) & (b1=0)) | ((<>aProcesses=0) & ((b2=1) | (b3=1)) & ((b20=1) | (b21=1))))
					ALERT:C41("Select the Process for adding Attributes.")
					$myOK:=0
				: ((aAttributes=0) & (b3=1) & ((b20=1) | (b21=1)))
					ALERT:C41("Select the Attribute for adding Causes.")
					$myOK:=0
				: ((v1s50="") & ((b20=1) | (b21=1)))
					ALERT:C41("Enter the value you wish to add.")
					$myOK:=0
				Else 
					$myOK:=1
			End case 
			If ($myOK=1)
				Case of 
					: (b1=1)
						b2:=0
						b3:=0
						$ptRay:=-><>aProcesses
						$ptFile:=->[QQQProcess:16]
						$ptField:=->[QQQProcess:16]Process:2
						//$ptCodeKey:=
						//$ptKey:=[Cause]AttributeKey
						$ptSequence:=->[QQQProcess:16]SequenceNum:1
						$ptCode:=->[QQQProcess:16]ProcessCode:3
						$ptNum:=->[QQQProcess:16]idUnique:4
						$ptRayNum:=-><>aProcessNums
					: (b2=1)
						b1:=0
						b3:=0
						$ptRay:=->aAttributes
						$ptFile:=->[QQQAttribute:17]
						$ptField:=->[QQQAttribute:17]Attribute:2
						$ptCodeKey:=->[QQQProcess:16]idUnique:4
						$ptKey:=->[QQQAttribute:17]ProcessKey:5
						$ptSequence:=->[QQQAttribute:17]SequenceNum:1
						$ptCode:=->[QQQAttribute:17]AttCode:3
						$ptNum:=->[QQQAttribute:17]idUnique:4
						$ptRayNum:=->aAttNums
					: (b3=1)
						b2:=0
						b1:=0
						$ptRay:=->aCauses
						$ptFile:=->[QQQCause:18]
						$ptField:=->[QQQCause:18]Cause:2
						$ptCodeKey:=->[QQQAttribute:17]idUnique:4
						$ptKey:=->[QQQCause:18]AttributeKey:4
						$ptSequence:=->[QQQCause:18]SequenceNum:1
						$ptCode:=->[QQQCause:18]CauseCode:3
						$ptNum:=->[QQQCause:18]CauseNum:5
						$ptRayNum:=->aCauseNums
				End case 
				Case of 
					: ((b23=1) & (Not:C34((b1=0) & (b2=0) & (b3=0))))
						QUERY:C277($ptFile->; $ptNum->=$ptRayNum->{$ptRay->})
						$ptField->:=Substring:C12(v1s50; 1; 27)
						$ptRay->{$ptRay->}:=Substring:C12(v1s50; 1; 27)
						SAVE RECORD:C53($ptFile->)
					: (b20=1)  //Insert a record
						If ($ptRay->#0)
							$s:=$ptRay->
						Else 
							$s:=Size of array:C274($ptRay->)+1
						End if 
						INSERT IN ARRAY:C227($ptRay->; $s)
						INSERT IN ARRAY:C227($ptRayNum->; $s)
						$ptRay->{$s}:=Substring:C12(v1s50; 1; 27)
						Case of 
							: (b1=1)
								QUERY:C277($ptFile->; $ptSequence->>=$s)
							: (b2=1)
								QUERY:C277([QQQAttribute:17]; [QQQAttribute:17]ProcessKey:5>=<>aProcessNums{<>aProcesses}; *)
								QUERY:C277([QQQAttribute:17];  & [QQQAttribute:17]SequenceNum:1>=$s)
							: (b3=1)
								QUERY:C277([QQQCause:18]; [QQQCause:18]AttributeKey:4>=aAttNums{aAttributes}; *)
								QUERY:C277([QQQCause:18];  & [QQQCause:18]SequenceNum:1>=$s)
						End case 
						FIRST RECORD:C50($ptFile->)
						For ($i; 1; Records in selection:C76($ptFile->))
							$ptSequence->:=$ptSequence->+1
							SAVE RECORD:C53($ptFile->)
							NEXT RECORD:C51($ptFile->)
						End for 
						CREATE RECORD:C68($ptFile->)
						$ptField->:=Substring:C12(v1s50; 1; 27)
						$ptSequence->:=$s
						$ptCode->:=Substring:C12(v2s50; 1; 3)
						$ptRayNum->{$s}:=Sequence number:C244($ptFile->)
						$ptNum->:=Sequence number:C244($ptFile->)
						Case of 
							: (b2=1)
								//                INSERT ELEMENT(aAttCodes;$s)
								//                aAttCodes{aAttributes}:=Substring(v2s50;1;3)
								[QQQAttribute:17]ProcessKey:5:=<>aProcessNums{<>aProcesses}
							: (b3=1)
								[QQQCause:18]AttributeKey:4:=aAttNums{aAttributes}
						End case 
						SAVE RECORD:C53($ptFile->)
						UNLOAD RECORD:C212($ptFile->)
					: (b21=1)
						$s:=Size of array:C274($ptRay->)+1
						INSERT IN ARRAY:C227($ptRay->; $s)
						INSERT IN ARRAY:C227($ptRayNum->; $s)
						$ptRay->{$s}:=Substring:C12(v1s50; 1; 27)
						$ptRay->:=$s
						CREATE RECORD:C68($ptFile->)
						$ptField->:=Substring:C12(v1s50; 1; 27)
						$ptSequence->:=$s
						$ptCode->:=Substring:C12(v2s50; 1; 3)
						Case of 
							: (b2=1)
								//               INSERT ELEMENT(aAttCodes;$s)
								//                aAttCodes{aAttributes}:=Substring(v2s50;1;3)
								[QQQAttribute:17]ProcessKey:5:=<>aProcessNums{<>aProcesses}
							: (b3=1)
								[QQQCause:18]AttributeKey:4:=aAttNums{aAttributes}
						End case 
						$ptRayNum->{$s}:=Sequence number:C244($ptFile->)
						$ptNum->:=Sequence number:C244($ptFile->)
						SAVE RECORD:C53($ptFile->)
						UNLOAD RECORD:C212($ptFile->)
					: (b22=1)
						Case of 
							: (b1=1)
								QUERY:C277([QQQAttribute:17]; [QQQAttribute:17]ProcessKey:5=<>aProcessNums{<>aProcesses})
								For ($i; 1; Records in selection:C76([QQQAttribute:17]))
									QUERY:C277([QQQCause:18]; [QQQCause:18]AttributeKey:4=[QQQAttribute:17]idUnique:4)
									DELETE SELECTION:C66([QQQCause:18])
									NEXT RECORD:C51([QQQAttribute:17])
								End for 
								DELETE SELECTION:C66([QQQAttribute:17])
								ARRAY TEXT:C222(aAttributes; 0)
								//                array TEXT(aAttCodes;0)
								QUERY:C277([QQQProcess:16]; [QQQProcess:16]idUnique:4=<>aProcessNums{<>aProcesses})
								DELETE RECORD:C58([QQQProcess:16])
								ALL RECORDS:C47([QQQProcess:16])
								ORDER BY:C49([QQQProcess:16]; [QQQProcess:16]SequenceNum:1)
								FIRST RECORD:C50([QQQProcess:16])
								For ($i; 1; Records in selection:C76([QQQProcess:16]))
									[QQQProcess:16]SequenceNum:1:=$i
									SAVE RECORD:C53([QQQProcess:16])
									NEXT RECORD:C51([QQQProcess:16])
								End for 
								UNLOAD RECORD:C212([QQQProcess:16])
								DELETE FROM ARRAY:C228(<>aProcessNums; <>aProcesses; 1)
								DELETE FROM ARRAY:C228(<>aProcesses; <>aProcesses; 1)
								<>aProcesses:=<>aProcesses-1
							: (b2=1)
								QUERY:C277([QQQCause:18]; [QQQCause:18]AttributeKey:4=[QQQAttribute:17]idUnique:4)
								DELETE SELECTION:C66([QQQCause:18])
								ARRAY TEXT:C222(aCauses; 0)
								QUERY:C277([QQQAttribute:17]; [QQQAttribute:17]idUnique:4=aAttNums{aAttributes})
								DELETE RECORD:C58([QQQAttribute:17])
								QUERY:C277([QQQAttribute:17]; [QQQAttribute:17]ProcessKey:5=<>aProcessNums{<>aProcesses})
								ORDER BY:C49([QQQAttribute:17]; [QQQAttribute:17]SequenceNum:1)
								FIRST RECORD:C50([QQQAttribute:17])
								For ($i; 1; Records in selection:C76([QQQAttribute:17]))
									[QQQAttribute:17]SequenceNum:1:=$i
									SAVE RECORD:C53([QQQAttribute:17])
									NEXT RECORD:C51([QQQAttribute:17])
								End for 
								DELETE FROM ARRAY:C228(aAttNums; aAttributes; 1)
								DELETE FROM ARRAY:C228(aAttributes; aAttributes; 1)
								aAttributes:=aAttributes-1
								UNLOAD RECORD:C212([QQQAttribute:17])
							: (b3=1)
								QUERY:C277([QQQCause:18]; [QQQCause:18]CauseNum:5=aCauseNums{aCauses})
								DELETE RECORD:C58([QQQCause:18])
								DELETE FROM ARRAY:C228(aCauseNums; aCauses; 1)
								DELETE FROM ARRAY:C228(aCauses; aCauses; 1)
								aCauses:=aCauses-1
								QUERY:C277([QQQCause:18]; [QQQCause:18]AttributeKey:4=aAttNums{aAttributes})
								ORDER BY:C49([QQQCause:18]; [QQQCause:18]SequenceNum:1)
								FIRST RECORD:C50([QQQCause:18])
								For ($i; 1; Records in selection:C76([QQQCause:18]))
									[QQQCause:18]SequenceNum:1:=$i
									SAVE RECORD:C53([QQQCause:18])
									NEXT RECORD:C51([QQQCause:18])
								End for 
								UNLOAD RECORD:C212([QQQCause:18])
						End case 
				End case 
				Case of 
					: (b1=1)
						jRayProcesses(0)
					: (b2=1)
						jRayAtts(0)
				End case 
			End if 
			MESSAGES ON:C181
		End if 
		HIGHLIGHT TEXT:C210(v1s50; 1; 50)
End case 
