If (<>aTableNames>1)
	$TableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	QUERY:C277([SyncRecord:109]; [SyncRecord:109]tableNum:4=$TableNum)
End if 