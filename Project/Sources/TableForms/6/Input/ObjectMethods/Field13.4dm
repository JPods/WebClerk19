If ([Service:6]complete:17=True:C214)
	//[Service]RS_DateCompleted:=Current date
	[Service:6]dtComplete:18:=DateTime_Enter
	vt06Complet:=Current time:C178
	d06Complete:=Current date:C33
Else 
	// [Service]RS_DateCompleted:=!00/00/00!
	[Service:6]dtComplete:18:=0
	vt06Complet:=?00:00:00?
	d06Complete:=!00-00-00!
End if 