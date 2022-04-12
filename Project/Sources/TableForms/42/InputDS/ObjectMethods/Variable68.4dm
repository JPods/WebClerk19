//F3
C_LONGINT:C283($areaList)
$areaList:=eItemPp
KeyModifierCurrent
Case of 
	: ((optKey=0) & (cmdKey=0) & (shftKey=0) & ([Customer:2]customerID:1#""))
		List_PplOrdLns($areaList; [Customer:2]customerID:1; 1)
	: ((optKey=1) & (cmdKey=1))
		List_ColorOrd($areaList)
	: (shftKey=1)
		List_CustOrds($areaList; "")
	: (optKey=1)
		List_CustPpls($areaList; "")
	: (cmdKey=1)
		List_CustBuy($areaList)  //last 5 invoices     
End case 
