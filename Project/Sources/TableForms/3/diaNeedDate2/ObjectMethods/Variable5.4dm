If (Before:C29)
	Case of 
		: (ptCurTable=(->[Order:3]))
			If ([Order:3]dateShipOn:31=!00-00-00!)
				[Order:3]dateShipOn:31:=Current date:C33
			End if 
			vDate1:=[Order:3]dateOrdered:4
			vdDateBeg:=[Order:3]dateShipOn:31
			vdDateEnd:=[Order:3]dateNeeded:5
		: (ptCurTable=(->[Proposal:42]))
			vDate1:=[Proposal:42]dateProposed:3
			vdDateBeg:=[Proposal:42]dateNeeded:4
			vdDateEnd:=[Proposal:42]dateNeeded:4
	End case 
	bSkipWkEnd:=Num:C11(<>boSkipWkEnd)
	bFixbyDays:=bSkipWkEnd
	jDaysWork(->vi4; bSkipWkEnd; bFixbyDays; ->vdDateBeg; ->vdDateEnd; [Customer:2]shippingDays:22; 1)
	v1:=jDayName(Day number:C114(vDate1))
	v2:=jDayName(Day number:C114(vdDateBeg))
	v3:=jDayName(Day number:C114(vdDateEnd))
End if 