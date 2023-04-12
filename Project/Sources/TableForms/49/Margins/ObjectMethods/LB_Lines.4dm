Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		var $thePrec : Integer
		$thePrec:=2
		LB_Lines.cur.discountedPrice:=Round:C94(LB_OrderLine.cur.unitPrice*(1-(0.01*LB_OrderLine.cur.discount)); $thePrec)
		LB_Lines.cur.extendedPrice:=LB_OrderLine.cur.qty*LB_OrderLine.cur.discountedPrice
		LB_Lines.cur.extendedCost:=LB_OrderLine.cur.qty*LB_OrderLine.cur.unitCost
		LB_Lines.cur.extendedWt:=LB_OrderLine.cur.qty*LB_OrderLine.cur.unitWt
		LB_Lines.cur.qtyBackLogged:=LB_OrderLine.cur.qty-LB_OrderLine.cur.qtyShipped
End case 