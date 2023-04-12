//%attributes = {"publishedWeb":true}
//Method: ReservationTimeEnd
C_LONGINT:C283($endCycle; $endCart; $k; $endTime)
$endTime:=DateTime_DTTo
$endCycle:=$endTime-(<>vlCycleTime*60)
$endCart:=$endTime-(<>vlCartTime*60)
TRACE:C157
READ WRITE:C146([Reservation:79])
QUERY:C277([Reservation:79]; [Reservation:79]dtActionLast:2<$endCycle; *)
QUERY:C277([Reservation:79];  | [Reservation:79]dtOriginated:7<<>vlCartTime; *)
QUERY:C277([Reservation:79];  & [Reservation:79]active:10=True:C214; *)
QUERY:C277([Reservation:79];  & [Reservation:79]idNumOrder:14=0)
$k:=Records in selection:C76([Reservation:79])
If ($k>0)
	FIRST RECORD:C50([Reservation:79])
	For ($i; 1; $k)
		LOAD RECORD:C52([Reservation:79])
		If (Not:C34(Locked:C147([Reservation:79])))
			[Reservation:79]active:10:=False:C215
			[Reservation:79]dtActionLast:2:=$endTime
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[Reservation:79]itemNum:1)
			LOAD RECORD:C52([Item:4])
			If (Not:C34(Locked:C147([Item:4])))
				[Reservation:79]idNumOrder:14:=-5
				[Item:4]qtyAllocated:72:=[Item:4]qtyAllocated:72-[Reservation:79]qtyReserved:6
				SAVE RECORD:C53([Item:4])
			Else 
				[Reservation:79]idNumOrder:14:=-1
			End if 
			UNLOAD RECORD:C212([Item:4])
			SAVE RECORD:C53([Reservation:79])
		End if 
		NEXT RECORD:C51([Reservation:79])
	End for 
	UNLOAD RECORD:C212([Reservation:79])
End if 
QUERY:C277([Reservation:79]; [Reservation:79]ideventLog:5="Pending")
$k:=Records in selection:C76([Reservation:79])
If ($k>0)
	FIRST RECORD:C50([Reservation:79])
	For ($i; 1; $k)
		LOAD RECORD:C52([Reservation:79])
		If (Not:C34(Locked:C147([Reservation:79])))
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[Reservation:79]itemNum:1)
			LOAD RECORD:C52([Item:4])
			If (Not:C34(Locked:C147([Item:4])))
				//[Reservation]eventID:="ClearThis"
				[Reservation:79]ideventLog:5:=-1
				[Item:4]qtyAllocated:72:=[Item:4]qtyAllocated:72-[Reservation:79]qtyReserved:6
				SAVE RECORD:C53([Item:4])
				UNLOAD RECORD:C212([Item:4])
				SAVE RECORD:C53([Reservation:79])
			End if 
		End if 
		NEXT RECORD:C51([Reservation:79])
	End for 
	UNLOAD RECORD:C212([Reservation:79])
End if 
READ ONLY:C145([Reservation:79])