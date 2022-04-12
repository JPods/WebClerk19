//%attributes = {"publishedWeb":true}
//Procedure: TC_ALExit
//January 2, 1996//TRACE
//called in AL Definitions
KeyModifierCurrent
C_BOOLEAN:C305($0)  //Entry Valid (True) or Entry Rejected (False)
C_LONGINT:C283($1)  //Area Name
C_LONGINT:C283($2)  //Action that Caused Entry Finished
$0:=True:C214
C_LONGINT:C283($col; $row)
C_BOOLEAN:C305($bdTime)
C_LONGINT:C283(eTimeList; eSignInOut; eOrdTime)
$bdTime:=False:C215
//  CHOPPED  AL_GetCurrCell($1; $col; $row)
ARRAY LONGINT:C221(aTCSelLns; 1)
aTCSelLns{1}:=$row
Case of 
	: ($1=eTimeList)  //from time card review 
		GOTO RECORD:C242([Time:56]; aTCTimeRecs{$row})
		Case of 
			: ($col=2)
				READ ONLY:C145([Employee:19])
				QUERY:C277([Employee:19]; [Employee:19]nameID:1=aTCNameID{$row})
				aTCHourWage{$row}:=[Employee:19]payRate:11
				UNLOAD RECORD:C212([Employee:19])
				READ WRITE:C146([Employee:19])
				//
			: (($col=5) | ($col=6))  //Date In; Time In
				TC_TimeLapse(0; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
				$bdTime:=True:C214
			: ($col=11)
				
			: ($col=7)  //Date Out; Time Out
				
				
				If (aTCDateOut{$row}=!00-00-00!)
					aTCDateOut{$row}:=Current date:C33
				End if 
				TC_TimeLapse(1; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
				$bdTime:=True:C214
			: ($col=8)  //Lapse
				TC_TimeLapse(2; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
				$bdTime:=True:C214
		End case 
		TC_FillArrays(-4; $row)
		SAVE RECORD:C53([Time:56])
		UNLOAD RECORD:C212([Time:56])
	: ($1=eSignInOut)
		GOTO RECORD:C242([Time:56]; aTCTimeRecs{$row})
		$doEnd:=False:C215
		Case of 
			: ($col=2)
				READ ONLY:C145([Employee:19])
				QUERY:C277([Employee:19]; [Employee:19]nameID:1=aTCNameID{$row})
				aTCHourWage{$row}:=[Employee:19]payRate:11
				UNLOAD RECORD:C212([Employee:19])
				READ WRITE:C146([Employee:19])
			: (($col=8) | ($col=12))
				If (aTCDateOut{$row}#!00-00-00!)
					TC_TimeLapse(0; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
				End if 
				$doEnd:=True:C214
			: (($col=9) | ($col=13))  //time out        //date out
				TC_TimeLapse(1; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
				$doEnd:=True:C214
			: ($col=10)
				TC_TimeLapse(2; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
				$doEnd:=True:C214
		End case 
		If ((Length:C16(aTCSignedIN{$row})=1) & ($doEnd))
			aTCSignedIN{$row}:=aTCSignedIN{$row}+"c"
		End if 
		TC_FillArrays(-4; $row)
		SAVE RECORD:C53([Time:56])
		UNLOAD RECORD:C212([Time:56])
	: ($1=eOrdTime)
		Case of 
			: ($col=2)
				READ ONLY:C145([Employee:19])
				QUERY:C277([Employee:19]; [Employee:19]nameID:1=aTCNameID{$row})
				aTCHourWage{$row}:=[Employee:19]payRate:11
				UNLOAD RECORD:C212([Employee:19])
				READ WRITE:C146([Employee:19])
			: (($col=7) | ($col=8))
				TC_TimeLapse(0; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
			: (($col=9) | ($col=10))
				TC_TimeLapse(1; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
			: ($col=11)
				TC_TimeLapse(2; ->aTCTimeIn{$row}; ->aTCTimeOut{$row}; ->aTCLapsed{$row}; ->aTCDateIn{$row}; ->aTCDateOut{$row})
		End case 
		GOTO RECORD:C242([Time:56]; aTCTimeRecs{$row})
		TC_FillArrays(-4; $row)
		SAVE RECORD:C53([Time:56])
		UNLOAD RECORD:C212([Time:56])
End case 
//  --  CHOPPED  AL_UpdateArrays($1; -2)
// -- AL_SetSelect($1; aTCSelLns)