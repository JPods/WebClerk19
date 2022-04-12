KeyModifierCurrent
Case of 
	: (cmdKey=1)
		GUI_TextEditDia(->[QQQCustomer:2]shipInstruct:24; "Customer Shipping Instructions")
	: (optKey=1)
		GUI_TextEditDia(->[Order:3]shipInstruct:46; "Order Shipping Instructions")
	Else 
		GUI_TextEditDia(->[Invoice:26]shipInstruct:40; "Invoice Shipping Instructions")
End case 