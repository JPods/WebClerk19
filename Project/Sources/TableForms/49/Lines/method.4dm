Case of 
	: (Form event code:C388=On Load:K2:1)
		
		// look at automatic relation
		//OBJECT SET SUBFORM(*; "SF_Lines"; "Lines")
		//OBJECT Get pointer(Object named; "_TOTAL_LB_Lines_qty_")->:=LB_Lines.ents.sum("qty")
		//OBJECT Get pointer(Object named; "_TOTAL_LB_Lines_qtyBackLogged_")->:=LB_Lines.ents.sum("qtyBackLogged")
		//OBJECT Get pointer(Object named; "_TOTAL_LB_Lines_extendedPrice_")->:=entry_o.amount
		
	: (Form event code:C388=On Clicked:K2:4)
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
	: (Form event code:C388=On Drop:K2:12)
		
		
	: (Form event code:C388=On After Keystroke:K2:26)
		
		
	: (Form event code:C388=On After Edit:K2:43)
		
		
	: (Form event code:C388=On Data Change:K2:15)
		Case of 
			: (FORM Event:C1606.objectName="_apply_qty_o")
				LB_Lines.calcQty(_apply_qty_r)
				//var $line : Object
				//For each ($line; LB_Lines.sel)
				//$line.qty:=Num(_apply_qty_r)
				//End for each 
				//LB_Lines.redraw()
			: (FORM Event:C1606.objectName="_apply_discount_o")
				LB_Lines.calcDiscount(_apply_discount_r)
				//var $line : Object
				//For each ($line; LB_Lines.sel)
				//$line.discount:=Num(_apply_disc_r)
				//End for each 
				//LB_Lines.redraw()
				
				
			: (FORM Event:C1606.objectName="_apply_unitPrice_o")
				LB_Lines.calcUnitPrice(_apply_unitPrice_r)
				
		End case 
		
	: (Form event code:C388=On Timer:K2:25)
		
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		
End case 