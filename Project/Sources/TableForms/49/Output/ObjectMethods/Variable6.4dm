KeyModifierCurrent

TRACE:C157

If (OptKey=0)
	MfgrTallyLineByCustomer(0)  // ("";"";"";"";!01/01/93!;Current date)
	
Else 
	variable1:="t"
	variable2:="01/01/00"
	variable3:="10/31/05"
	http_OrderLineSalesByItem
	
End if 