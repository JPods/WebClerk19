//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 07/01/02
	//Who: Bill James
	//Description: Exporting emails and phone numbers
	VERSION_960
End if 
//
iLoText14:=""
iLoText15:=""
C_TEXT:C284(iLo255String1)
If (iLo255String1#"")
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ExportScript"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=iLo255String1)
	If (Records in selection:C76([TallyMaster:60])=1)
		iLoText14:=[TallyMaster:60]script:9
		iLoText15:=[TallyMaster:60]after:7
	End if 
End if 


C_LONGINT:C283($1; $2; $incRec; $incFld; $copy; $copyTotal)
//C_POINTER($3)

$viProgressID:=Progress New
$k:=$1
For ($incRec; 1; $1)  //number of records
	If (iLoText14#"")
		ExecuteText(0; iLoText14)
	End if 
	//Thermo_Update ($incRec)
	ProgressUpdate($viProgressID; $incRec; $k; "Exporting "+Table name:C256(curTableNum))
	
	If (<>ThermoAbort)
		$incRec:=$1
	End if 
	C_TEXT:C284($theDelim)
	$theDelim:=vFldDelim
	C_TEXT:C284($theValue)
	For ($incFld; 1; $2)
		If (<>vbExportEndRecord)
			$theDelim:=vFldDelim
		Else 
			If ($incFld=$2)
				$theDelim:=vRecDelim
			Else 
				$theDelim:=vFldDelim
			End if 
		End if 
		
		Case of 
			: (aMatchType{$incFld}="A")
				$theValue:=Replace string:C233(Field:C253(curTableNum; aMatchNum{$incFld})->; "\r"; "")
				Case of 
					: (aExportFormat{$incFld}=0)
						If (vFldSepBeg=Char:C90(34))
							$theValue:=Replace string:C233($theValue; Char:C90(34); Char:C90(34)+Char:C90(34))
						End if 
						SEND PACKET:C103(myDoc; vFldSepBeg+$theValue+vFldSepEnd+$theDelim)
					: (aExportFormat{$incFld}=1)
						$theValue:=Format_Phone(Field:C253(curTableNum; aMatchNum{$incFld})->)
						SEND PACKET:C103(myDoc; vFldSepBeg+$theValue+vFldSepEnd+$theDelim)
					: (aExportFormat{$incFld}=2)
						//$theValue:=Field(curTableNum; aMatchNum{$incFld}->)
						SEND PACKET:C103(myDoc; vFldSepBeg+$theValue+vFldSepEnd+$theDelim)
				End case 
			: (aMatchType{$incFld}="T")
				$theValue:=Replace string:C233(Field:C253(curTableNum; aMatchNum{$incFld})->; Storage:C1525.char.crlf; "\r")
				If ((Position:C15(Char:C90(13); Field:C253(curTableNum; aMatchNum{$incFld})->)>0) & (vFldSepBeg=""))
					SEND PACKET:C103(myDoc; Char:C90(34)+$theValue+Char:C90(34)+$theDelim)
				Else 
					SEND PACKET:C103(myDoc; vFldSepBeg+$theValue+vFldSepEnd+$theDelim)
				End if 
			: ((aMatchType{$incFld}="R") | (aMatchType{$incFld}="I") | (aMatchType{$incFld}="H"))
				SEND PACKET:C103(myDoc; vFldSepBeg+String:C10(Field:C253(curTableNum; aMatchNum{$incFld})->)+vFldSepEnd+$theDelim)
			: (aMatchType{$incFld}="D")
				Case of 
					: (Field:C253(curTableNum; aMatchNum{$incFld})->=!00-00-00!)
						SEND PACKET:C103(myDoc; vFldSepBeg+""+vFldSepEnd+$theDelim)
					: (vRecDelim=Storage:C1525.char.crlf)
						SEND PACKET:C103(myDoc; vFldSepBeg+String:C10(Field:C253(curTableNum; aMatchNum{$incFld})->)+" 12:00:00 PM"+vFldSepEnd+$theDelim)
					Else 
						SEND PACKET:C103(myDoc; vFldSepBeg+String:C10(Field:C253(curTableNum; aMatchNum{$incFld})->)+vFldSepEnd+$theDelim)
				End case 
			: (aMatchType{$incFld}="L")
				If (Field name:C257(Field:C253(curTableNum; aMatchNum{$incFld}))="DT@")
					SEND PACKET:C103(myDoc; vFldSepBeg+jDateTimeRBoth(Field:C253(curTableNum; aMatchNum{$incFld})->)+vFldSepEnd+$theDelim)
				Else 
					SEND PACKET:C103(myDoc; vFldSepBeg+String:C10(Field:C253(curTableNum; aMatchNum{$incFld})->)+vFldSepEnd+$theDelim)
				End if 
			: (aMatchType{$incFld}="B")
				SEND PACKET:C103(myDoc; vFldSepBeg+String:C10(Num:C11(Field:C253(curTableNum; aMatchNum{$incFld})->=True:C214))+vFldSepEnd+$theDelim)
				//        : (aMatchType{$incFld}="P")
				//          ALERT("Picture Files may not be exported.  Use the Clipboard.")
		End case 
	End for 
	If (iLoText15#"")
		ExecuteText(0; iLoText15)
	End if 
	If (<>vbExportEndRecord)
		SEND PACKET:C103(myDoc; vFldSepBeg+"EndRecord"+vFldSepEnd+vRecDelim)
	End if 
	NEXT RECORD:C51(Table:C252(curTableNum)->)
End for 

Progress QUIT($viProgressID)
iLoText14:=""
iLoText15:=""