If (<>aTableNames>1)
	$TableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	QUERY:C277([QQQTemplate:130]; [QQQTemplate:130]tableNum:2=$TableNum)
End if 