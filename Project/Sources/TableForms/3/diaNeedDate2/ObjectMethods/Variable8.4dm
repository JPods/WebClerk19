bFixbyDays:=1
jDaysWork(->vi4; bSkipWkEnd; bFixbyDays; ->vdDateBeg; ->vdDateEnd; [Customer:2]shippingDays:22; 2)
v2:=jDayName(Day number:C114(vdDateBeg))
v3:=jDayName(Day number:C114(vdDateEnd))