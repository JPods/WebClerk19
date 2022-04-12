If (Self:C308->>0)
	[CronJob:82]TableNum:33:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	If ([CronJob:82]TableNum:33>0)
		[CronJob:82]TableName:38:=Table name:C256([CronJob:82]TableNum:33)
	End if 
End if 