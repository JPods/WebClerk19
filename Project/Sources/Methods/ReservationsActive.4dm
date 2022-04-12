//%attributes = {"publishedWeb":true}
//Method: ReservationsActive
MESSAGES OFF:C175
QUERY:C277([Reservation:79]; [Reservation:79]active:10=True:C214)
MESSAGES OFF:C175
ProcessTableOpen(->[Reservation:79])