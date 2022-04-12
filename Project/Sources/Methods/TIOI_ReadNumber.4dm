//%attributes = {"publishedWeb":true}
//Procedure: TIOI_ReadNumber
//Puts a number of char from the input stream into the buffer
C_POINTER:C301($1)  //pointer to integer: index of command to run
C_POINTER:C301($2)  //Ptr to File ID or Nil
C_POINTER:C301($3)  //Ptr to Text: Path of File to Read
C_LONGINT:C283($WantLen; $UnreadLen)
$WantLen:=Trunc:C95(aTIOTypePtr{$1->}->; 0)
If (Not:C34(bTIOIError))
	$UnreadLen:=Length:C16(tTIOIUnRead)
	If ($UnreadLen>0)
		If ($UnreadLen>$WantLen)
			tTIOIBuffer:=Substring:C12(tTIOIUnRead; 1; $WantLen)
			tTIOIUnRead:=Substring:C12(tTIOIUnRead; $WantLen+1)
			$WantLen:=0
		Else 
			tTIOIBuffer:=tTIOIUnRead
			tTIOIUnRead:=""
			$WantLen:=$WantLen-$UnreadLen
		End if 
	Else 
		tTIOIBuffer:=""
	End if 
	If (Not:C34(bTIOIAtEOF))  //don't read any more if already EOF
		If (Not:C34(Is nil pointer:C315($2)))  //there is a file to read
			ON ERR CALL:C155("TIOI_GetErrNum")
			If ($WantLen>0)  //any unsatisfied want?
				C_LONGINT:C283($myOK)
				RECEIVE PACKET:C104($2->; tTIOIUnRead; $WantLen)  //main Receive Packet
				$myOK:=OK  //Store for safe keeping
				If (bTIOIError)
					ELog_NewRecMsg(lTIOIErrNum; "TIOI Error"; "Error in "+Util_GetShortName($3->)+" on "+<>aTInTypes{<>ciTInReadNm}+" "+String:C10($WantLen))
				End if 
				If ($myOK=1)
					tTIOIBuffer:=tTIOIBuffer+tTIOIUnRead
					tTIOIUnRead:=""
				Else 
					bTIOIError:=True:C214
				End if 
			End if   //$WantLen>0
			If (tTIOIUnRead="")  //prevent EOF Test if there is unread
				RECEIVE PACKET:C104($2->; tTIOIUnRead; 1)
				$myOK:=OK  //Store for safe Keeping
				If (bTIOIError)
					ELog_NewRecMsg(lTIOIErrNum; "TIOI Error"; "Error in "+Util_GetShortName($3->)+" on "+<>aTInTypes{<>ciTInReadNm}+" "+String:C10($WantLen))
				End if 
				bTIOIAtEOF:=($myOK=0)  //$myOK=0: EOF encountered
			End if 
			ON ERR CALL:C155("")
		Else 
			If ($WantLen>0)  //unsatisfied want, but no file
				bTIOIError:=True:C214
			End if 
		End if   //valid file?
	End if   //not EOF
Else 
	ELog_NewRecMsg(-1; "TIOI Error"; "Unreported error in "+Util_GetShortName($3->)+" on read before "+<>aTInTypes{<>ciTInReadNm}+" "+String:C10($WantLen))
	$1->:=-3  //terminate; -3 so that after the immeadiate increment it will be -2
End if 