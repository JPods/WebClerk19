C_OBJECT:C1216($obEvent)
$obEvent:=FORM Event:C1606
Case of 
	: ($obEvent.code=On Data Change:K2:15)
		C_OBJECT:C1216($obRec)
		If (Form:C1466.PopupChoiceCurrent.id=Null:C1517)
			$obRec:=New object:C1471
			$obRec:=ds:C1482.PopupChoice.new()
			$obRec.choice:=Form:C1466.PopupChoiceCurrent.choice
			$obRec.alternate:=Form:C1466.PopupChoiceCurrent.alternate
			$obRec.arrayName:=process_o.currentEntity.arrayName
			$result_o:=$obRec.save()
			Form:C1466.PopupChoiceCurrent.id:=$obRec.id
		Else 
			C_OBJECT:C1216($obRec)
			$obRec:=ds:C1482.PopupChoice.query(" id = :1 "; Form:C1466.PopupChoiceCurrent.id).first()
			$obRec.choice:=Form:C1466.PopupChoiceCurrent.choice
			$obRec.alternate:=Form:C1466.PopupChoiceCurrent.alternate
			$result_o:=$obRec.save()
		End if 
		//LISTBOX GET CELL POSITION({*; }object{; X; Y}; column; row{; colVar})
		
	: ($obEvent.code=On Clicked:K2:4)
		C_LONGINT:C283($mouseX; $mouseY; $columnNum; $rowNum)
		C_POINTER:C301($ptColumnVar)
		LISTBOX GET CELL POSITION:C971(*; "LBPopupChoice"; $mouseX; $mouseY; $columnNum; $rowNum; $ptColumnVar)
		
		
		
End case 