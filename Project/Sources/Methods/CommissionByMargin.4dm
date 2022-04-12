//%attributes = {}
Case of 
	: ([Order:3]grossMargin:47<25)
		[Order:3]repCommission:9:=0
		[Order:3]salesCommission:11:=0
	: ([Order:3]grossMargin:47<33)
		[Order:3]repCommission:9:=0
		[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*0.035; 2)
	: ([Order:3]grossMargin:47<39)
		[Order:3]repCommission:9:=0
		[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*0.055; 2)
	: ([Order:3]grossMargin:47<45)
		[Order:3]repCommission:9:=0
		[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*0.075; 2)
	: ([Order:3]grossMargin:47<49)
		[Order:3]repCommission:9:=0
		[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*0.095; 2)
	: ([Order:3]grossMargin:47<54)
		[Order:3]repCommission:9:=0
		[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*0.115; 2)
	Else 
		[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*0.145; 2)
		[Order:3]repCommission:9:=0
End case 
