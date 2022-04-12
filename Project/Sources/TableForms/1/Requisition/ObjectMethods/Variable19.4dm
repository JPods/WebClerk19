If (vDate1>vDate2)
	vDate2:=vDate1
End if 
jBetweenDates("Select Date Range"; vDate1; vDate2)
vDate1:=vdDateBeg
vDate2:=vdDateEnd