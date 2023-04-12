KeyModifierCurrent

Case of 
	: ((OptKey=1) & (CmdKey=1))
		
		OrderLineProductionSchedule
		
	: (OptKey=0)
		MfgrTallyLineByCustomer(1)  //("";"";"";"";!01/01/93!;Current date)
		
	Else 
		variable1:="t"
		variable2:="01/01/00"
		variable3:="10/31/05"
		// moved to weeding 2023-01-03: http_OrderLineSalesByItem 
		
End case 