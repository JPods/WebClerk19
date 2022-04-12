//%attributes = {"publishedWeb":true}
//Procedure: TIOI_ReadString
//scans for a String in the Input Stream
//puts that string plus all that preceeded it in the buffer.
C_POINTER:C301($1)  //pointer to integer: index of command to run
C_POINTER:C301($2)  //Ptr to File ID or Nil
C_POINTER:C301($3)  //Ptr to path of program file, for error reporting
C_BOOLEAN:C305($4)  //leave search string in Buffer when done?
C_TEXT:C284($MatchStr)
$MatchStr:=aTIOTypePtr{$1->}->
If (Not:C34(bTIOIError))  //no pending error already
	C_LONGINT:C283($WantLen; $UnreadLen)
	$WantLen:=Length:C16($MatchStr)
	$UnreadLen:=Length:C16(tTIOIUnRead)
	C_LONGINT:C283($pos)
	If ($UnreadLen>=$WantLen)
		$pos:=Position:C15($MatchStr; tTIOIUnRead)
		If ($pos>0)
			If ($4)  //put search string in buffer
				tTIOIBuffer:=Substring:C12(tTIOIUnRead; 1; $pos+$WantLen-1)
			Else 
				tTIOIBuffer:=Substring:C12(tTIOIUnRead; 1; $pos-1)
			End if 
			tTIOIUnRead:=Substring:C12(tTIOIUnRead; $pos+$WantLen)
			$WantLen:=0
		End if 
	End if 
	If (Not:C34(bTIOIAtEOF))  //don't read any more if already EOF
		If (Not:C34(Is nil pointer:C315($2)))  //there is a file to read
			ON ERR CALL:C155("TIOI_GetErrNum")
			If ($WantLen>0)  //any unsatisfied want?
				tTIOIBuffer:=tTIOIUnRead
				tTIOIUnRead:=""
				$pos:=0
				C_LONGINT:C283($myOK)
				Repeat 
					If ($WantLen>1)
						RECEIVE PACKET:C104($2->; tTIOIUnRead; $WantLen-1)
						$myOK:=OK  //Store for safe Keeping
						If (bTIOIError)
							ELog_NewRecMsg(lTIOIErrNum; "TIOI Error"; "Error in "+Util_GetShortName($3->)+" on "+<>aTInTypes{<>ciTInReadSt}+" "+$MatchStr)
						End if 
						If ($myOK=1)
							tTIOIBuffer:=tTIOIBuffer+tTIOIUnRead
						End if 
					Else 
						$myOK:=1
					End if 
					If ($myOK=1)
						$pos:=Position:C15($MatchStr; tTIOIBuffer)
						If ($pos=0)
							RECEIVE PACKET:C104($2->; tTIOIUnRead; $MatchStr[[1]])
							$myOK:=OK  //Store for safe Keeping
							If (bTIOIError)
								ELog_NewRecMsg(lTIOIErrNum; "TIOI Error"; "Error in "+Util_GetShortName($3->)+" on "+<>aTInTypes{<>ciTInReadSt}+" "+$MatchStr)
							End if 
							If ($myOK=1)
								tTIOIBuffer:=tTIOIBuffer+tTIOIUnRead+$MatchStr[[1]]
							End if 
						End if 
					End if 
				Until (($pos>0) | ($myOK<=0))
				If ($pos>0)
					tTIOIUnRead:=Substring:C12(tTIOIBuffer; $pos+$WantLen)
					If ($4)  //put search string in buffer
						tTIOIBuffer:=Substring:C12(tTIOIBuffer; 1; $pos+$WantLen-1)
					Else 
						tTIOIBuffer:=Substring:C12(tTIOIBuffer; 1; $pos-1)
					End if 
				Else 
					tTIOIUnRead:=""
				End if 
			Else 
				$myOK:=1  //here to check EOF in case Unread Empty and no Unsatisfied want
			End if   //$WantLen>0 
			If (tTIOIUnRead="")  //prevent EOF Test if there is unread
				If ($myOK<=0)
					bTIOIError:=True:C214
				Else 
					RECEIVE PACKET:C104($2->; tTIOIUnRead; 1)
					$myOK:=OK  //Store for safe Keeping
					If (bTIOIError)
						ELog_NewRecMsg(lTIOIErrNum; "TIOI Error"; "Error in "+Util_GetShortName($3->)+" on "+<>aTInTypes{<>ciTInReadSt}+" "+$MatchStr)
					End if 
					bTIOIAtEOF:=($myOK=0)  //$myOK=0: EOF encountered
				End if 
			End if   //tTIOIUnRead=""
			ON ERR CALL:C155("")
		Else 
			If ($WantLen>0)  //unsatisfied want, but no file
				bTIOIError:=True:C214
			End if 
		End if   //valid file?
	End if   //not EOF
Else 
	ELog_NewRecMsg(-1; "TIOI Error"; "Unreported error in "+Util_GetShortName($3->)+" on read before "+<>aTInTypes{<>ciTInReadSt}+" "+$MatchStr)
	$1->:=-3  //terminate; -3 so that after the immeadiate increment it will be -2
End if 