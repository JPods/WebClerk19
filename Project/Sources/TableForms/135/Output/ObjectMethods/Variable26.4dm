If (Self:C308->>0)
	C_LONGINT:C283($tableNum)
	$tableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	If ($tableNum>0)
		READ ONLY:C145([QQQCounter:41])
		QUERY:C277([QQQCounter:41]; [QQQCounter:41]TableNum:4=$tableNum)
		iLoLongInt1:=[QQQCounter:41]Counter:1
		REDUCE SELECTION:C351([QQQCounter:41]; 0)
		QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum)
	End if 
End if 
