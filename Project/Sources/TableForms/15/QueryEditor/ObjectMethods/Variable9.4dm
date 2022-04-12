// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/23/15, 14:01:10
// ----------------------------------------------------
// Method: [Default].DiaSearch.Variable9
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170928_1235 added viPublish also in layout and Save

If (False:C215)
	TCStrong_prf_v142_PictBundle
	//02/03/03.prf
	//code changes to replace PictBundle plugin
End if 
C_LONGINT:C283($error; $i; $sizeSelect; viPublish)
Case of 
	: (ALProEvt=1)
		//  CHOPPED  aTmp20Str1:=AL_GetLine(eSrchRecs)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		vText1:=[TallyMaster:60]script:9
		viPublish:=[TallyMaster:60]publish:25  // ### jwm ### 20170928_1235
		KeyModifierCurrent
		If ((OptKey=1) & (False:C215))  // ### jwm ### 20150223_1356 causes 4D to Crash
			$doChange:=(UserInPassWordGroup("UnlockRecord"))
			If ($doChange)
				//CANCEL  // ### jwm ### 20150223_1329
				ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
			End if 
		End if 
		//02/03/03.prf
		
		//C_PICTURE(<>myBdl1)
		//<>myBdl1:=CreateBundle 
		//<>myBdl1:=[TallyMaster]PictField
		//SetBdlPos (<>myBdl1;0)
		//GetBdlArray (<>myBdl1;aQueryBooleans)
		//GetBdlArray (<>myBdl1;aQueryFieldNames)
		//GetBdlArray (<>myBdl1;aQueryOperators)
		//GetBdlArray (<>myBdl1;aQueryValues)
		
		BLOB_TO_VAR(->[TallyMaster:60]obField:30; ->aQueryBooleans; ->aQueryFieldNames; ->aQueryOperators; ->aQueryValues)
		
		UNLOAD RECORD:C212([TallyMaster:60])
		
		C_TEXT:C284($tableName)
		C_LONGINT:C283($soa; $inc)
		$tableName:=<>aTableNames{<>aTableNames}
		$soa:=Size of array:C274(aQueryFieldNames)
		For ($inc; 1; $soa)
			If (Length:C16(aQueryFieldNames{$inc})>0)
				If (aQueryFieldNames{$inc}[[1]]#"[")
					aQueryFieldNames{$inc}:="["+$tableName+"]"+aQueryFieldNames{$inc}
				End if 
			End if 
		End for 
		
		//  --  CHOPPED  AL_UpdateArrays(eSrchPat; -2)
	: (ALProEvt=2)
		//  CHOPPED  aTmp20Str1:=AL_GetLine(eSrchRecs)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		vText1:=[TallyMaster:60]script:9
		viPublish:=[TallyMaster:60]publish:25  // ### jwm ### 20170928_1235
		UNLOAD RECORD:C212([TallyMaster:60])
		If ((doQuickQuote=1) | (ptCurTable=Table:C252(curTableNum)))
			doSearch:=10
		Else 
			//<>processAlt:=New process("jQueryProcess";<>tcPrsMemory;String(Count user processes)+"- "+Table name(curTableNum);curTableNum;-1;vText1)
			DB_ShowCurrentSelection(Table:C252(curTableNum); vText1; 1; "")
			CANCEL:C270
		End if 
End case 
ALProEvt:=0
