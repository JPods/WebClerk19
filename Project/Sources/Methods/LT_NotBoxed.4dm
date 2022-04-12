//%attributes = {"publishedWeb":true}
//Method: LT_NotBoxed
//Scripts
If ((vHere=1) & (ptCurTable=(->[Order:3])))
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	CREATE EMPTY SET:C140([Order:3]; "Current")
	For (vi1; 1; vi2)
		QUERY:C277([LoadItem:87]; [LoadItem:87]tableNum:1=3; *)
		QUERY:C277([LoadItem:87];  & [LoadItem:87]orderNum:2=[Order:3]orderNum:2)
		If (Records in selection:C76([LoadItem:87])=0)
			ADD TO SET:C119([Order:3]; "Current")
		End if 
		NEXT RECORD:C51([Order:3])
	End for 
	If (Records in set:C195("Current")>0)
		ProcessTableOpen(3; "Current")
	End if 
	CLEAR SET:C117("Current")
Else 
	ALERT:C41("You must be in Orders to execute this.")
End if 