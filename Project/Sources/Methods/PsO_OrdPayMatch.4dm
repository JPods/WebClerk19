//%attributes = {"publishedWeb":true}
//Method: PsO_OrdPayMatch
CONFIRM:C162("Keep current set of Orders?")
If (OK=0)
	QUERY:C277([Order:3]; [Order:3]status:59="Fix pay@"; *)
	QUERY:C277([Order:3];  | [Order:3]status:59="Pay_Fix2Order@"; *)
	QUERY:C277([Order:3])
End if 
vi2:=Records in selection:C76([Order:3])
CONFIRM:C162("Force payments to match order total:"+String:C10(vi2))
If (OK=1)
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For (vi1; 1; vi2)
		QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
		If ([Order:3]total:27#[Payment:28]Amount:1)
			[Payment:28]Amount:1:=[Order:3]total:27
			[Payment:28]AmountAvailable:19:=[Order:3]total:27
			SAVE RECORD:C53([Payment:28])
		End if 
		[Order:3]status:59:="Pay_Match"
		SAVE RECORD:C53([Order:3])
		NEXT RECORD:C51([Order:3])
	End for 
End if 