Case of 
	: (Form event code:C388=On Load:K2:1)
		_apply_qty_r:=0
		_apply_discount_r:=0
		_apply_unitPrice_r:=0
		
	: (Form event code:C388=On Data Change:K2:15)
		//LB_Lines.cur:=LB_Lines.ents[FORM Event.row-1]
		LB_Lines.calcLine()
		
	: (Form event code:C388=On After Edit:K2:43)
		//LB_Lines.calcLine(LB_Lines.cur)
		
	: (Form event code:C388=On Drag Over:K2:13)
		
	: (Form event code:C388=On Drop:K2:12)
		
		LB_Lines.dropItems(_LB_Item_.sel)
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		dragFrom:="LB_Lines"
		
End case 