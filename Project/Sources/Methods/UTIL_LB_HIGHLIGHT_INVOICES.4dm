//%attributes = {}
  // UTIL_LB_HIGHLIGHT_INVOICES

C_OBJECT:C1216($0)

Case of 
	: (Form:C1466.highlight="PAID")
		
		If (Not:C34(This:C1470.Paid))
			
			$0:=New object:C1471("fill";"#FFE8E8")
			$0.cell:=New object:C1471
			$0.cell.Column1:=New object:C1471("fill";"#FF9999";"fontWeight";"bold")
			$0.cell.Column2:=$0.cell.Column1
			
		End if 
		
	: (Form:C1466.highlight="VALUES")
		
		Case of 
			: (This:C1470.Total>1600)
				$0:=New object:C1471("fill";"#E8FFE8")  //"stroke";"#336633";
				$0.cell:=New object:C1471
				$0.cell.Column1:=New object:C1471("fill";"#99FF99";"fontWeight";"bold")  //;"stroke";"#006600")
				
			: (This:C1470.Total>1200) & (This:C1470.Total<=1600)
				$0:=New object:C1471("fill";"#CCFFFF")
				$0.cell:=New object:C1471
				$0.cell.Column1:=New object:C1471("fill";"#99FFFF";"fontWeight";"bold")
				
			: (This:C1470.Total<300)
				$0:=New object:C1471("fill";"#FFFFE8")
				$0.cell:=New object:C1471
				$0.cell.Column1:=New object:C1471("fill";"#FFFF99";"fontWeight";"bold")
				
		End case 
		
End case 

If (Not:C34(Undefined:C82($0)))
	
	$0.cell.Column2:=$0.cell.Column1
	$0.cell.Column5:=New object:C1471
	$0.cell.Column5.fontWeight:="bold"
	$0.cell.Column5.fontStyle:="italic"
	
End if 