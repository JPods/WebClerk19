If (<>aTableNames>1)
	$TableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=$TableNum)
End if 