//%attributes = {"publishedWeb":true}
//Script from Payments to mark the orders to ship
CONFIRM:C162("Mark Orders for these payments 'OK 2 Ship'")
If (OK=1)
	vi2:=Records in selection:C76([Payment:28])
	FIRST RECORD:C50([Payment:28])
	vText1:=String:C10(DateTime_Enter)
	For (vi1; 1; vi2)
		QUERY:C277([Order:3]; [Order:3]idNum:2=[Payment:28]idNumOrder:2)
		[Order:3]status:59:="OK_2_Ship"
		SAVE RECORD:C53([Order:3])
		[Payment:28]comment:5:="Complete_"+vText1
		SAVE RECORD:C53([Order:3])
		SAVE RECORD:C53([Payment:28])
		NEXT RECORD:C51([Payment:28])
	End for 
	//
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Payment:28])
	//
	QUERY:C277([Order:3]; [Order:3]status:59="OK_2_Ship")
	ProcessTableOpen(Table:C252(->[Order:3]))
	//
End if 