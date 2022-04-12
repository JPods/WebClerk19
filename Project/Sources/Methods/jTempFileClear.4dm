//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/02/09, 23:52:55
// ----------------------------------------------------
// Method: jTempFileClear
// Description: Not called but is at the end of the jAcceptButton method.  Review its purpose.  CheckThis
// Was intended as a means of saving web based changes to a locked record.  I will have to review this.  With Blobs this might be worth implementing.
// TempRecs are also created for Serialized actions
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k; $tally; $1)
C_POINTER:C301($filePt)
C_TEXT:C284($myText)
ARRAY LONGINT:C221($aTempRecs; 0)
If (Count parameters:C259=1)
	$k:=$1
Else 
	QUERY:C277([TempRec:55]; [TempRec:55]tableNum:1>0)
	$k:=Records in selection:C76([TempRec:55])
End if 
//ALERT(String($K))
If (viEndUserSecurityLevel=0)  //CheckThis
	viEndUserSecurityLevel:=1
End if 
If ($k>0)
	$tally:=0
	SELECTION TO ARRAY:C260([TempRec:55]; $aTempRecs)
	For ($i; 1; $k)
		GOTO RECORD:C242([TempRec:55]; $aTempRecs{$i})
		LOAD RECORD:C52([TempRec:55])
		If (Not:C34(Locked:C147([TempRec:55])))
			Case of 
				: ([TempRec:55]Purpose:6=1)  //excute script on a record
					GOTO RECORD:C242(Table:C252(Abs:C99([TempRec:55]tableNum:1))->; Abs:C99([TempRec:55]RecordNumOrig:2))
					//ALERT("Running [TempRec]Purpose")
					If (Not:C34(Locked:C147(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)))  //CheckThis, made this a TallyMaster instead of executing a script
						Execute_TallyMaster([TempRec:55]Action:5)
						DELETE RECORD:C58([TempRec:55])
					End if 
				: ([TempRec:55]Purpose:6=0)
					PUSH RECORD:C176([TempRec:55])
					If ([TempRec:55]RecordNumOrig:2#0)
						GOTO RECORD:C242(Table:C252(Abs:C99([TempRec:55]tableNum:1))->; Abs:C99([TempRec:55]RecordNumOrig:2))
						LOAD RECORD:C52(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
						Case of 
							: (Locked:C147(Table:C252(Abs:C99([TempRec:55]tableNum:1))->))
								$tally:=-1
							: (([TempRec:55]RecordNumOrig:2<0) | ([TempRec:55]RecordNumNew:3<0) | ([TempRec:55]tableNum:1=0) | ([TempRec:55]KeyField:4=0))
								DELETE RECORD:C58([TempRec:55])
							: (([TempRec:55]RecordNumOrig:2<0) & ([TempRec:55]RecordNumNew:3=0))
								DELETE RECORD:C58([TempRec:55])
								DELETE RECORD:C58(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
							Else 
								$myText:=PackMakeText(Field:C253([TempRec:55]tableNum:1; [TempRec:55]KeyField:4))
								PUSH RECORD:C176(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
								GOTO RECORD:C242(Table:C252(Abs:C99([TempRec:55]tableNum:1))->; [TempRec:55]RecordNumNew:3)
								LOAD RECORD:C52(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
								If (Locked:C147(Table:C252(Abs:C99([TempRec:55]tableNum:1))->))
									POP RECORD:C177([TempRec:55])
									POP RECORD:C177(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
								Else 
									PackMakeTyped(Field:C253([TempRec:55]tableNum:1; [TempRec:55]KeyField:4); $myText)
									SAVE RECORD:C53(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
									POP RECORD:C177(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
									DELETE RECORD:C58(Table:C252(Abs:C99([TempRec:55]tableNum:1))->)
									POP RECORD:C177([TempRec:55])
									DELETE RECORD:C58([TempRec:55])
								End if 
						End case 
					End if 
			End case 
		End if 
	End for 
	ARRAY LONGINT:C221($aTempRecs; 0)
End if 
