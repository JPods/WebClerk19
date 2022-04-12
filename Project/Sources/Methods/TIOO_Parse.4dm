//%attributes = {"publishedWeb":true}
//Procedure: TIOO_Parse
C_LONGINT:C283($0)  //error
C_POINTER:C301($1)  //ponter to Text: Path to TextOut File to Parse
C_BOOLEAN:C305($2)  //Parse embedded TextOut Calls in-line or just note them with an elem
C_LONGINT:C283($done)  //repeat until $done#0
C_TEXT:C284(vtLineNum)  // debug line numbers

$done:=0
If (Test path name:C476($1->)>=0)
	$FileID:=Open document:C264($1->; "*"; Read mode:K24:5)  // ### jwm ### 20180525_1311
	C_TEXT:C284($RowText)
	C_LONGINT:C283($lineNum)
	$lineNum:=0
	Repeat 
		//Get Data for a line
		$lineNum:=$lineNum+1
		vtLineNum:=String:C10($lineNum)  // ### jwm ### 20170313_1529 for debug console message
		$Type:=TIO_ParseRawTxt($FileID)
		If ($Type#"")
			C_LONGINT:C283($soa)
			$soa:=Size of array:C274(aTIOTypeCd)+1
			INSERT IN ARRAY:C227(aTIOTypeCd; $soa)
			INSERT IN ARRAY:C227(aTIOTypePtr; $soa)
			INSERT IN ARRAY:C227(aTIOTyIndex; $soa)
			$fia:=Find in array:C230(<>aTOutTypes; $Type)
			aTIOTypeCd{$soa}:=$fia
			Case of 
				: ($fia=<>ciTOutBlank)
					aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //just ignore blank lines..          
				: ($fia=<>ciTOutWrite)
					aTIOTypePtr{$soa}:=TIO_ParseFlVrCn(->tTIOTxtData)
				: ($fia=<>ciTOutFRTxt)
					aTIOTypePtr{$soa}:=TIO_ParseFRText(->tTIOTxtData)
					aTIOTypeCd{$soa}:=<>ciTOutFRTkn
				: ($fia=<>ciTOutFRDoc)
					aTIOTypePtr{$soa}:=TIO_ParseFRDoc(->tTIOTxtData)
					aTIOTypeCd{$soa}:=<>ciTOutFRTkn
				: ($fia=<>ciTOutBName)
					If (iTIONameBgn=0)
						iTIONameBgn:=$soa
						iTIONameEnd:=0
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
						aTIOTyIndex{$soa}:=32000  //pre fill the index that will terminate if not updated by an end name
					Else 
						aTIOTypePtr{$soa}:=<>cptNilPoint  //error      
					End if 
				: ($fia=<>ciTOutEName)
					If ((iTIONameEnd=0) & (iTIONameBgn>0) & (iTIONameBgn<$soa))
						iTIONameEnd:=$soa
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
						aTIOTyIndex{iTIONameBgn}:=$soa+1  //put the next elem in to the Begin Name's index to skip name rows
					Else 
						aTIOTypePtr{$soa}:=<>cptNilPoint  //error      
					End if 
				: ($fia=<>ciTOutBLoop)
					aTIOTypePtr{$soa}:=TIO_ParseLoopB(->tTIOTxtData; $soa; False:C215)  //false info not blank
					aTIOTyIndex{$soa}:=32000  //pre fill the index that will terminate if not updated by an end loop
				: ($fia=<>ciTOutELoop)
					aTIOTyIndex{$soa}:=TIO_RStackPop  //returns index of Begin Loop
					If (aTIOTyIndex{$soa}>0)
						aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result 
						aTIOTyIndex{aTIOTyIndex{$soa}}:=$soa+1  //put the next elem in to the Begin Loop's index to skip Zero pass
					Else 
						aTIOTypePtr{$soa}:=<>cptNilPoint  //error      
					End if 
				: ($fia=<>ciTOutVersn)
					aTIOTypePtr{$soa}:=TIO_ParseVers(->tTIOTxtData)
				: ($fia=<>ciTOutTxOut)  //embedded TextOut Call
					If ($2)  //in-line vs field
						//parse embedded TextOut in-line
						If (TIOO_ParseInLn(->tTIOTxtData)=-1)  //failed to parse
							$done:=-1
						End if 
						$soa:=Size of array:C274(aTIOTypeCd)
					Else 
						//parse embedded TextOut as a field
						aTIOTypePtr{$soa}:=TIO_ParseTIOFld(->tTIOTxtData)
					End if 
				: ($fia=<>ciTOutDbug)  //Toggle Debug event logging
					aTIOTypePtr{$soa}:=->[Control:1]Approved:1  //a non-error generic result
				Else 
					aTIOTypePtr{$soa}:=<>cptNilPoint
			End case 
			If ($done=0)  //don't report the error 2 times for in-line TextOut
				If (Is nil pointer:C315(aTIOTypePtr{$soa}))
					ELog_NewRecMsg(-1; "TIOO Error"; "Error in row #"+String:C10($lineNum)+" of File "+Util_GetShortName($1->))
					$done:=-1
				End if 
			End if 
		Else 
			$done:=1  //successful ending
		End if 
	Until ($done#0)
	CLOSE DOCUMENT:C267($FileID)
Else 
	ELog_NewRecMsg(-47; "TIOO Error"; "The file "+$1->+" doesn't exist.")
	$done:=-1
End if 
$0:=$done