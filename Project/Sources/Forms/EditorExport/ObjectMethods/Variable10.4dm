If (Form:C1466.LB_Fields.sel#Null:C1517)
	var $o : Object
	For each ($o; Form:C1466.LB_Fields.sel)
		Form:C1466.LB_Use.ents.push($o)
	End for each 
	OBJECT SET ENABLED:C1123(*; "bNew_o"; (Form:C1466.LB_Use.ents.length>0))
End if 