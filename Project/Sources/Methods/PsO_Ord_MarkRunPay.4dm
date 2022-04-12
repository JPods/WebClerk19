//%attributes = {"publishedWeb":true}
//Script from Orders to mark the payments to run
CONFIRM:C162("Mark Payment for these Orders 'OK_2_RunCC'")
If (OK=1)
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For (vi1; 1; vi2)
		QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
		FIRST RECORD:C50([Payment:28])
		If ([Order:3]total:27#[Payment:28]amount:1)
			[Order:3]status:59:="Pay MisMatch"
		Else 
			[Order:3]status:59:="OK_2_RunCC"
			If (([Payment:28]cardApproval:15="Pend") | ([Payment:28]cardApproval:15="SSLi") | ([Payment:28]cardApproval:15="Fail"))
				[Payment:28]comment:5:="Run Card"
				SAVE RECORD:C53([Payment:28])
			End if 
		End if 
		SAVE RECORD:C53([Order:3])
		NEXT RECORD:C51([Order:3])
	End for 
	//
	QUERY:C277([Payment:28]; [Payment:28]comment:5="Run Card")
	ProcessTableOpen(Table:C252(->[Payment:28]))
	//
End if 
//Or_CompleteSelected