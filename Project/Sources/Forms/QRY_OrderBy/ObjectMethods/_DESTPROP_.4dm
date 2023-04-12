C_OBJECT:C1216($object)
C_LONGINT:C283($index)

$evt:=Form event code:C388

Case of 
	: ($evt=On Clicked:K2:4)
		
	: ($evt=On Begin Drag Over:K2:44)
		Form:C1466.clipObject:=New object:C1471("source";"SELF";"object";Form:C1466.criteriaSelected)
		
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
					Form:C1466.criteriaList:=Form:C1466.criteriaList
					If (Form:C1466.clipObject.object#Null:C1517)
						QRY_SetSortLine (Form:C1466.propertySelected;$drop)
					End if 
					
				: (Form:C1466.clipObject.source="SELF")
					$index:=Form:C1466.criteriaList.indexOf(Form:C1466.clipObject.object)
					Form:C1466.criteriaList.remove($index)
					Form:C1466.criteriaList.insert($drop;Form:C1466.clipObject.object)
					
				Else 
					
			End case 
			Form:C1466.clipObject:=New object:C1471
			Form:C1466.criteriaList:=Form:C1466.criteriaList
			
		End if 
		
End case 