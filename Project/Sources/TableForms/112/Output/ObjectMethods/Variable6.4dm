If (<>aTableNames>1)
	$TableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	QUERY:C277([SyncMap:112]; [SyncMap:112]TableName:4=$TableNum)
End if 