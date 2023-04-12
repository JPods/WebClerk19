If (Form:C1466.LB_Use.cur#Null:C1517)
	
	var $c; $c2 : Collection
	$c:=Form:C1466.LB_Use.sel
	Form:C1466.LB_Use.sel:=Null:C1517
	$c2:=Form:C1466.LB_Use.ents
	Form:C1466.LB_Use.ents:=$c2.minus($c)
	//Form.LB_Use.ents:=Form.LB_Use.ents.minus($c)
	//Form.LB_Use.remove(Form.LB_Use.pos; 1)
	
	
End if 