KeyModifierCurrent
If (optKey=0)
	GUI_TextEditDia(->[Order:3]shipInstruct:46; "Order Shipping Instructions")
Else 
	GUI_TextEditDia(->[QQQCustomer:2]shipInstruct:24; "Customer Shipping Instructions")
End if 