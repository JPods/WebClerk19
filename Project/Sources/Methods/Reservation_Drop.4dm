//%attributes = {"publishedWeb":true}
READ WRITE:C146([Reservation:79])
QUERY:C277([Reservation:79]; [Reservation:79]itemNum:1=[Item:4]itemNum:1; *)
QUERY:C277([Reservation:79];  & [Reservation:79]active:10=True:C214; *)
QUERY:C277([Reservation:79];  & [Reservation:79]eventLogid:5=vleventID)
TRACE:C157
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Reservation:79])
FIRST RECORD:C50([Reservation:79])
For ($i; 1; $k)
	//If (Not(Locked([Item])))
	//[Item]QtyAllocated:=[Item]QtyAllocated-[Reservation]QtyReserved
	//SAVE RECORD([Item])
	//Else 
	//[Reservation]eventID:=-2
	//End if 
	[Reservation:79]active:10:=False:C215
	SAVE RECORD:C53([Reservation:79])
	NEXT RECORD:C51([Reservation:79])
End for 
READ ONLY:C145([Reservation:79])