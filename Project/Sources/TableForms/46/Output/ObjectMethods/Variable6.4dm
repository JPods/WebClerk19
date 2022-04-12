If (<>aTableNames>1)
	$TableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	QUERY:C277([UserReport:46]; [UserReport:46]tableNum:3=$TableNum)
End if 