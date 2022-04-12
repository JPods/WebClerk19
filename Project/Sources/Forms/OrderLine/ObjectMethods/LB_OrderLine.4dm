Case of 
	: (Form event code:C388=On Load:K2:1)
		//LB_OrderLine.data:=New object
		//LB_OrderLine.data:=ds.Orderline.query("idNumOrder = 1:"; process_o.cur.idNum)
		
	: (Form event code:C388=On Data Change:K2:15)
		var $thePrec : Integer
		$thePrec:=2
		LB_OrderLine.cur.discountedPrice:=Round:C94(LB_OrderLine.cur.unitPrice*(1-(0.01*LB_OrderLine.cur.discount)); $thePrec)
		LB_OrderLine.cur.extendedPrice:=LB_OrderLine.cur.qty*LB_OrderLine.cur.discountedPrice
		LB_OrderLine.cur.extendedCost:=LB_OrderLine.cur.qty*LB_OrderLine.cur.unitCost
		LB_OrderLine.cur.extendedWt:=LB_OrderLine.cur.qty*LB_OrderLine.cur.unitWt
		LB_OrderLine.cur.qtyBackLogged:=LB_OrderLine.cur.qty-LB_OrderLine.cur.qtyShipped
End case 