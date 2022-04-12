//%attributes = {"publishedWeb":true}
jDateTimeUserCl("Enter Date/Time Range")
If (OK=1)
	QUERY:C277([Reservation:79]; [Reservation:79]dtReservation:18>=vlDTStart; *)
	QUERY:C277([Reservation:79];  & [Reservation:79]dtReservation:18<=vlDTEnd)
	ProcessTableOpen(->[Reservation:79])
End if 


