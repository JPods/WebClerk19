If ([TallyMaster:60]idUnique:4>0)
	CONFIRM:C162("Set to negative UniqueID, automatic overwrite?")
	If (OK=1)
		PUSH RECORD:C176([TallyMaster:60])
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]idUnique:4<0)
		ORDER BY:C49([TallyMaster:60]idUnique:4; >)
		FIRST RECORD:C50([TallyMaster:60])
		$nextNum:=[TallyMaster:60]idUnique:4-1
		POP RECORD:C177([TallyMaster:60])
		[TallyMaster:60]idUnique:4:=$nextNum
	End if 
End if 