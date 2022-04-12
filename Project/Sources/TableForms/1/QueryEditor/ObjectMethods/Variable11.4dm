If (False:C215)
	TCStrong_prf_v142_PictBundle
	//02/03/03.prf
	//code changes to replace PictBundle plugin
End if 
If (vText1#"")
	$vName:=Request:C163("Enter name for search pattern.")
	If ($vName#"")
		CREATE RECORD:C68([TallyMaster:60])
		
		[TallyMaster:60]tableNum:1:=curTableNum
		[TallyMaster:60]purpose:3:="SEARCH"
		[TallyMaster:60]name:8:=$vName
		[TallyMaster:60]script:9:=vText1
		
		
		// $voQuery.details:=$aObQueries
		If ([TallyMaster:60]obGeneral:41=Null:C1517)
			[TallyMaster:60]obGeneral:41:=New object:C1471
		End if 
		[TallyMaster:60]obGeneral:41.query:=QueryEd_ObjectBuild
		
		VAR_TO_BLOB(->[TallyMaster:60]obField:30; ->aQueryBooleans; ->aQueryFieldNames; ->aQueryOperators; ->aQueryValues)
		
		SAVE RECORD:C53([TallyMaster:60])
		INSERT IN ARRAY:C227(aTmp20Str1; 1)
		INSERT IN ARRAY:C227(aTmpLong1; 1)
		aTmp20Str1{1}:=$vName
		aTmpLong1{1}:=Record number:C243([TallyMaster:60])
		UNLOAD RECORD:C212([TallyMaster:60])
		//  --  CHOPPED  AL_UpdateArrays(eSrchRecs; -2)
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 


