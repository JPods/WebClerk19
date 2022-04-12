If (Form:C1466.criteria_Pos>0)
	Form:C1466.criteria.remove(Form:C1466.criteria_Pos-1)
	If (Form:C1466.criteria.length>0)
		Form:C1466.criteria[0].logicOperator:=Form:C1466.pictGrey
		Form:C1466.criteria[0].logicOperatorChoice:=""
	End if 
	Form:C1466.criteria:=Form:C1466.criteria
End if 