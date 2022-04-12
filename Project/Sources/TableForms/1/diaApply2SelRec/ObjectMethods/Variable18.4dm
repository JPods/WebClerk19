C_LONGINT:C283(bRemainder; $k; $recInc; $recCnt)
$relock:=False:C215
FIRST RECORD:C50(Table:C252(curTableNum)->)
If (Locked:C147(Table:C252(curTableNum)->))
	READ WRITE:C146(Table:C252(curTableNum)->)
	$relock:=True:C214
End if 
KeyModifierCurrent
Case of 
	: (OptKey=1)
		CONFIRM:C162("Clean extra spaces and illegal characters from listed fields?")
		If (OK=1)
			TRACE:C157
			$k:=Size of array:C274(aMatchField)
			For ($i; $k; 1; -1)
				If ((aMatchType{$i}#"A") & (aMatchType{$i}#"T"))
					DELETE FROM ARRAY:C228(aMatchField; $i; 1)
					DELETE FROM ARRAY:C228(aMatchType; $i; 1)
					DELETE FROM ARRAY:C228(aMatchNum; $i; 1)
					DELETE FROM ARRAY:C228(aCntMatFlds; $i; 1)
				End if 
			End for 
			$k:=Size of array:C274(aMatchField)
			If ($k>0)
				ARRAY LONGINT:C221(aCntMatFlds; $k)
				For ($i; 1; $k)
					aCntMatFlds{$i}:=aMatchNum{$i}
				End for 
				$recCnt:=Records in selection:C76(Table:C252(curTableNum)->)
				FIRST RECORD:C50(Table:C252(curTableNum)->)
				For ($recInc; 1; $recCnt)
					For ($i; 1; $k)
						Field:C253(curTableNum; aCntMatFlds{$i})->:=Parse_UnWanted(Field:C253(curTableNum; aCntMatFlds{$i})->)
					End for 
					SAVE RECORD:C53(Table:C252(curTableNum)->)
					NEXT RECORD:C51(Table:C252(curTableNum)->)
				End for 
			End if 
		End if 
	: (CmdKey=1)
		CONFIRM:C162("Replace with all CAPITAL characters from listed fields?")
		If (OK=1)
			$k:=Size of array:C274(aMatchField)
			For ($i; $k; 1; -1)
				If ((aMatchType{$i}#"A") & (aMatchType{$i}#"T"))
					DELETE FROM ARRAY:C228(aMatchField; $i; 1)
					DELETE FROM ARRAY:C228(aMatchType; $i; 1)
					DELETE FROM ARRAY:C228(aMatchNum; $i; 1)
					DELETE FROM ARRAY:C228(aCntMatFlds; $i; 1)
				End if 
			End for 
			$k:=Size of array:C274(aMatchField)
			If ($k>0)
				ARRAY LONGINT:C221(aCntMatFlds; $k)
				For ($i; 1; $k)
					aCntMatFlds{$i}:=aMatchNum{$i}
				End for 
				$recCnt:=Records in selection:C76(Table:C252(curTableNum)->)
				FIRST RECORD:C50(Table:C252(curTableNum)->)
				For ($recInc; 1; $recCnt)
					For ($i; 1; $k)
						Field:C253(curTableNum; aCntMatFlds{$i})->:=Uppercase:C13(Field:C253(curTableNum; aCntMatFlds{$i})->)
					End for 
					SAVE RECORD:C53(Table:C252(curTableNum)->)
					NEXT RECORD:C51(Table:C252(curTableNum)->)
				End for 
			End if 
		End if 
	Else 
		If ((Size of array:C274(aImpFields)>0) & (Size of array:C274(aImpFields)=Size of array:C274(aMatchField)))
			BEEP:C151
			CONFIRM:C162("This change CANNOT be undone.  Are you very sure you want this change.")
			If (OK=1)
				READ WRITE:C146(Table:C252(curTableNum)->)
				jappMultipleRec
				ReadOnlyFiles
			End if 
		Else 
			If (Size of array:C274(aImpFields)=0)
				ALERT:C41("You must define the information to be applied.")
			Else 
				ALERT:C41("The number of Data Fields and Matching Fields do not match.")
			End if 
		End if 
End case 
If ($relock)
	CONFIRM:C162("Relock file")
	If (OK=1)
		READ ONLY:C145(Table:C252(curTableNum)->)
	End if 
End if 