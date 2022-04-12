$w:=Find in array:C230(<>aTableNums; [Word:99]tableNum:2)
TRACE:C157
If ($w>0)
	//$tableName:=<>aTableNames{$w}
	If ((Get last field number:C255([Word:99]tableNum:2)>=[Word:99]fieldNum:7) & ([Word:99]fieldNum:7>0))
		$theType:=Type:C295(Field:C253([Word:99]tableNum:2; [Word:99]fieldNum:7)->)
		REDUCE SELECTION:C351(Table:C252([Word:99]tableNum:2)->; 0)
		Case of 
			: ($theType=Is alpha field:K8:1)
				QUERY:C277(Table:C252([Word:99]tableNum:2)->; Field:C253([Word:99]tableNum:2; [Word:99]fieldNum:7)->=[Word:99]relatedAlpha:8)
			: ($theType=Is longint:K8:6)
				QUERY:C277(Table:C252([Word:99]tableNum:2)->; Field:C253([Word:99]tableNum:2; [Word:99]fieldNum:7)->=[Word:99]relatedLongInt:9)
			Else 
				ALERT:C41("Only fields of type String and Longint are supported.")
		End case 
		If (Records in selection:C76(Table:C252([Word:99]tableNum:2)->)>0)
			curTableNum:=[Word:99]tableNum:2
			ProcessTableOpen
		Else 
			ALERT:C41("No Match")
		End if 
	End if 
End if 