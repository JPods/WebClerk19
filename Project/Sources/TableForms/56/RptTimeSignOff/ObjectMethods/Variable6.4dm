
Case of 
	: ([QQQTime:56]Rate:9=[Employee:19]payRate:11)
		vPayType:="Reg"
	: ([QQQTime:56]Rate:9>[Employee:19]payRate:11)
		vPayType:="OT"
	: ([QQQTime:56]Rate:9<[Employee:19]payRate:11)
		vPayType:="Sub"
End case 
vOrdTime:=Round:C94([QQQTime:56]LapseTime:8*[QQQTime:56]PerCentActive:18*0.01/3600; 2)
vTimeTotal:=vTimeTotal+vOrdTime
