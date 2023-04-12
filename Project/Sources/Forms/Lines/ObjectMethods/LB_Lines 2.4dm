Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		//LB_Lines.calcLine(LB_Lines.cur)
		
		
		
	: (Form event code:C388=On After Edit:K2:43)
		LB_Lines.calcLine(LB_Lines.cur)
		
	: (Form event code:C388=On Drag Over:K2:13)
		
	: (Form event code:C388=On Drop:K2:12)
		If (dragFrom="LB_Item")
			If (LB_Item.sel#Null:C1517)
				var $oItem; $oLine : Object
				For each ($o; LB_Item.sel)
					$oLine:=New object:C1471
					$oLine:=cs:C1710.cLine.new("OrderLine"; $o; process_o)
					LB_Lines.ents.push($oLine)
					$oLine.calc("OrderLine"; LB_Lines.ents[LB_Lines.ents.length-1])
				End for each 
			End if 
		End if 
	: (Form event code:C388=On Begin Drag Over:K2:44)
		dragFrom:="LB_Lines"
		
End case 