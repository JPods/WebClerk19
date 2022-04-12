If (Self:C308->>0)
	[TallyMaster:60]tableNum:1:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
	If ([TallyMaster:60]tableNum:1>0)
		oLo20String1:=Table name:C256([TallyMaster:60]tableNum:1)
	End if 
End if 