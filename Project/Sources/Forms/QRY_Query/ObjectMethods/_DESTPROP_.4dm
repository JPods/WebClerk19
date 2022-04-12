C_LONGINT:C283($index)

$evt:=Form event code:C388

Case of 
	: ($evt=On Drag Over:K2:13)
		If (Form:C1466.clipObject=Null:C1517)
			$0:=-1
		Else 
			If (OB Is empty:C1297(Form:C1466.clipObject))
				$0:=-1
			End if 
		End if 
		
	: ($evt=On Drop:K2:12)
		If (Form:C1466.clipObject#Null:C1517)
			$drop:=Drop position:C608
			If ($drop=-1)
				$drop:=Form:C1466.criteria.length+1
			Else 
				$drop:=$drop-1
			End if 
			Case of 
				: (Form:C1466.clipObject.source="SRC")
					If (Form:C1466.clipObject.object#Null:C1517)
						QRY_SetCriteriaLine (Form:C1466.clipObject.object;$drop)
					End if 
					
				: (Form:C1466.clipObject.source="SELF")
					$index:=Form:C1466.criteria.indexOf(Form:C1466.clipObject.object)
					Form:C1466.criteria.remove($index)
					Form:C1466.criteria.insert($drop;Form:C1466.clipObject.object)
					Form:C1466.criteria[0].logicOperator:=Form:C1466.pictGrey
					Form:C1466.criteria[0].logicOperatorChoice:=""
					
				Else 
					
			End case 
			For ($i;1;Form:C1466.criteria.length-1)
				If (Form:C1466.criteria[$i].logicOperatorChoice="")
					Form:C1466.criteria[$i].logicOperatorChoice:="and"
					Form:C1466.criteria[$i].logicOperator:=Get localized string:C991("operator_and")+" "+Form:C1466.emojis.charMenu
				End if 
			End for 
			Form:C1466.clipObject:=New object:C1471
			Form:C1466.criteria:=Form:C1466.criteria
		End if 
		
	: ($evt=On Begin Drag Over:K2:44)
		Form:C1466.clipObject:=New object:C1471("source";"SELF";"object";Form:C1466.criteria_Cur)
		
	: ($evt=On Row Moved:K2:32)
		
		  //
End case 