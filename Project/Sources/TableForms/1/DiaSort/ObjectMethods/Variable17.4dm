Sort_Build
If (vText1#"")
	$vName:=Request:C163("Enter name for sort pattern.")
	If (($vName#"") & (OK=1))
		CREATE RECORD:C68([TallyMaster:60])
		
		[TallyMaster:60]tableNum:1:=curTableNum
		[TallyMaster:60]purpose:3:="SORT"
		[TallyMaster:60]name:8:=$vName
		[TallyMaster:60]script:9:=vText1
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