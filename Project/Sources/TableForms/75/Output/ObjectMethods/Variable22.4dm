Srch_SetBefore("Search Selection")
QUERY SELECTION:C341([UserReport:46]; [UserReport:46]tableNum:3=2; *)
QUERY SELECTION:C341([UserReport:46])
Srch_SetEnd("Search Selection")
CREATE EMPTY SET:C140([Customer:2]; "Current")
vi2:=Records in selection:C76([EventLog:75])
FIRST RECORD:C50([EventLog:75])
For (vi1; 1; vi2)
	If ([EventLog:75]customerID:38#"")
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[EventLog:75]customerID:38)
		If (Records in selection:C76([Customer:2])>0)
			ADD TO SET:C119([Customer:2]; "Current")
		End if 
	End if 
	NEXT RECORD:C51([EventLog:75])
End for 
If (Records in set:C195("Current")>0)
	USE SET:C118("Current")
	ProcessTableOpen(Table:C252(->[Customer:2])*-1)
End if 
CLEAR SET:C117("Current")