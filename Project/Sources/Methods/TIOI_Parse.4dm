//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:21:33
// ----------------------------------------------------
// Method: TIOI_Parse
// Description
// Reason:  <>ciTInFRTkn
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160126_1556 test to see if file was opened successfully
// ### jwm ### 20170412_1148 restored original method

C_LONGINT:C283($0)  //error
C_POINTER:C301($1)  //ponter to Text: Path to TextIn File to Parse
C_BOOLEAN:C305($2)  //Parse embedded TextIn Calls in-line or just note them with an elem
C_LONGINT:C283($done)  //repeat until $done#0
C_TEXT:C284(vtLineNum)

$done:=0
If (Test path name:C476($1->)>=0)
	$FileID:=Open document:C264($1->)
	If (OK=1)  // ### jwm ### 20160126_1556 test to see if file was opened successfully
		C_TEXT:C284($RowText)
		C_LONGINT:C283($lineNum)
		$lineNum:=0
		//TRACE
		Repeat 
			//Get Data for a line
			$lineNum:=$lineNum+1
			vtLineNum:=String:C10($lineNum)  // ### jwm ### 20170313_1529 for debug console message
			$Type:=TIO_ParseRawTxt($FileID)
			If ($Type#"")
				C_LONGINT:C283($soa; $fia)
				$soa:=Size of array:C274(aTIOTypeCd)+1
				INSERT IN ARRAY:C227(aTIOTypeCd; $soa)
				INSERT IN ARRAY:C227(aTIOTypePtr; $soa)
				INSERT IN ARRAY:C227(aTIOTyIndex; $soa)
				$fia:=Find in array:C230(<>aTInTypes; $Type)
				aTIOTypeCd{$soa}:=$fia
				C_LONGINT:C283($LastIsIndex)
				
				Case of 
					: ($fia=<>ciTInBlank)
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //just ignore blank lines..
					: ($fia=<>ciTInReadNm)
						aTIOTypePtr{$soa}:=TIO_ParseNumber(->tTIOTxtData)
					: ($fia=<>ciTInReadSt)
						aTIOTypePtr{$soa}:=TIO_ParseString(->tTIOTxtData)
					: ($fia=<>ciTInRdToSt)
						aTIOTypePtr{$soa}:=TIO_ParseString(->tTIOTxtData)
					: ($fia=<>ciTInUnRead)
						aTIOTypePtr{$soa}:=TIO_ParseNumber(->tTIOTxtData)
					: ($fia=<>ciTInPutBuf)
						aTIOTypePtr{$soa}:=TIO_ParseFldVar(->tTIOTxtData)
					: ($fia=<>ciTInSetBuf)
						aTIOTypePtr{$soa}:=TIO_ParseString(->tTIOTxtData)
					: ($fia=<>ciTInFRTxt)
						aTIOTypePtr{$soa}:=TIO_ParseFRText(->tTIOTxtData)
						aTIOTypeCd{$soa}:=<>ciTInFRTkn
					: ($fia=<>ciTInFRDoc)
						//TRACE
						aTIOTypePtr{$soa}:=TIO_ParseFRDoc(->tTIOTxtData)
						aTIOTypeCd{$soa}:=<>ciTInFRTkn
					: ($fia=<>ciTInBIsLst)
						TIOI_IsStackPsh
						TIO_RStackPush($soa)  //to allow Exit stack check on End Is List
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
					: ($fia=<>ciTInIsBuff)
						aTIOTypePtr{$soa}:=TIO_ParseWildSt(->tTIOTxtData)
						$LastIsIndex:=TIOI_IsStackGet
						If ($LastIsIndex>0)
							$soa:=TIOI_AddExitCmd($soa)
							aTIOTyIndex{$LastIsIndex}:=$soa  //put the this elem into the last Is's index to skip failed is's
						End if 
						If (Not:C34(TIOI_IsStackSet($soa)))  //store this index for next is Command
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error
						End if 
					: (($fia=<>ciTInReadEr) | ($fia=<>ciTInIsEOF))
						$LastIsIndex:=TIOI_IsStackGet
						If ($LastIsIndex>0)
							$soa:=TIOI_AddExitCmd($soa)
							aTIOTyIndex{$LastIsIndex}:=$soa  //put the this elem into the last Is's index to skip failed is's
						End if 
						If (TIOI_IsStackSet($soa))  //store this index for next is Command
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error
						End if 
					: ($fia=<>ciTInIsOthr)
						$LastIsIndex:=TIOI_IsStackGet
						If ($LastIsIndex>0)
							$soa:=TIOI_AddExitCmd($soa)
							aTIOTyIndex{$LastIsIndex}:=$soa+1  //put the next elem into the last Is's index to skip failed is's
						End if 
						If (TIOI_IsStackSet($soa))  //store this index for next is Command
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error
						End if 
					: ($fia=<>ciTInEIsLst)
						$LastIsIndex:=TIOI_IsStackGet
						If ($LastIsIndex>0)
							aTIOTyIndex{$LastIsIndex}:=$soa+1  //put the next elem into the last Is's index to skip failed is's
						End if 
						If (TIOI_IsStackPop)
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error
						End if 
						C_LONGINT:C283($BeginIsLst)
						$BeginIsLst:=TIO_RStackPop  //returns index of Begin Is List
						If ($BeginIsLst>0)
							C_LONGINT:C283($ExitIndex)
							Repeat 
								$ExitIndex:=TIOI_StackIXPop($BeginIsLst)  //only return indexs > the begin Is List for this Is List
								If ($ExitIndex>0)
									aTIOTyIndex{$ExitIndex}:=$soa+1  //put the next elem in to the Exit Loop's index
								End if 
							Until ($ExitIndex<0)
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error      
						End if 
					: ($fia=<>ciTInBName)
						If (iTIONameBgn=0)
							iTIONameBgn:=$soa
							iTIONameEnd:=0
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
							aTIOTyIndex{$soa}:=32000  //pre fill index that will terminate if not updated by an end name
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error
						End if 
					: ($fia=<>ciTInEName)
						If ((iTIONameEnd=0) & (iTIONameBgn>0) & (iTIONameBgn<$soa))
							iTIONameEnd:=$soa
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
							aTIOTyIndex{iTIONameBgn}:=$soa+1  //put the next elem in to the Begin Name's index to skip name rows
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error
						End if 
					: ($fia=<>ciTInBLoop)
						If (tTIOTxtData#"")
							aTIOTypePtr{$soa}:=TIO_ParseLoopB(->tTIOTxtData; $soa)
						Else 
							TIO_RStackPush($soa)
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1
							aTIOTypeCd{$soa}:=<>ciTInBLpNoI  //Begin Loop w/ No Iterator
						End if 
						aTIOTyIndex{$soa}:=32000  //pre fill index that will terminate if not updated by an end loop
					: ($fia=<>ciTInELoop)
						aTIOTyIndex{$soa}:=TIO_RStackPop  //returns index of Begin Loop
						If (aTIOTyIndex{$soa}>0)
							aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result 
							aTIOTyIndex{aTIOTyIndex{$soa}}:=$soa+1  //put the next elem in to the Begin Loop's index to skip Zero pass
							C_LONGINT:C283($ExitIndex)
							Repeat 
								$ExitIndex:=TIOI_ExStackPop(aTIOTyIndex{$soa})  //only return indexs > the begin loop for this loop
								If ($ExitIndex>0)
									aTIOTyIndex{$ExitIndex}:=$soa+1  //put the next elem in to the Exit Loop's index
								End if 
							Until ($ExitIndex<0)
						Else 
							aTIOTypePtr{$soa}:=<>cptNilPoint  //error      
						End if 
					: ($fia=<>ciTInExitLp)
						TIOI_ExStackPsh($soa)
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result 
						aTIOTyIndex{$soa}:=32000  //pre fill index that will terminate if not updated by an end loop
					: ($fia=<>ciTInQuit)
						aTIOTypePtr{$soa}:=TIO_ParseString(->tTIOTxtData)
					: ($fia=<>ciTInStop)
						aTIOTypePtr{$soa}:=TIO_ParseString(->tTIOTxtData)
					: ($fia=<>ciTInVersn)
						aTIOTypePtr{$soa}:=TIO_ParseVers(->tTIOTxtData)
					: ($fia=<>ciTInTextIn)
						// TRACE
						If ($2)  //in-line vs field
							//parse embedded TextOut in-line
							If (TIOI_ParseInLn(->tTIOTxtData)=-1)  //failed to parse
								$done:=-1
							End if 
							$soa:=Size of array:C274(aTIOTypeCd)
						Else 
							//parse embedded TextOut as a field
							aTIOTypePtr{$soa}:=TIO_ParseTIOFld(->tTIOTxtData)
						End if 
					: ($fia=<>ciTInDebug)
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
					Else 
						aTIOTypePtr{$soa}:=<>cptNilPoint
				End case 
				If ($done=0)  //don't report the error 2 times for in-line TextOut
					If (Is nil pointer:C315(aTIOTypePtr{$soa}))
						ELog_NewRecMsg(-1; "TIOI Error"; "Error in row #"+String:C10($lineNum)+" of File "+HFS_ShortName($1->))
						$done:=-1
					End if 
				End if 
			Else 
				//TRACE
				$done:=1
			End if 
		Until ($done#0)
	Else 
		If (Error=-43)  // ### jwm ### 20160126_1557 if file is already open
			ELog_NewRecMsg(-43; "TIOI Error"; "The file "+$1->+" Is already open.")
		End if 
	End if 
	CLOSE DOCUMENT:C267($FileID)
Else 
	ELog_NewRecMsg(-47; "TIOI Error"; "The file "+$1->+" doesn't exist.")
	$done:=-1
End if 
$0:=$done
