C_LONGINT:C283($error; $incLines; $cntLines)
Case of 
	: (ALProEvt=-2)
	: (ALProEvt=-1)
	: (ALProEvt=0)
	: (ALProEvt=1)
		//Single Click
		
		
		////  CHOPPED  AL_UpdateFields (eItemWarehouse;2)
	: (ALProEvt=2)
		//Double Click
		TextToArray([ItemWarehouse:117]locationid:4; ->aText1; "-")
		$parts:=Size of array:C274(aText1)
		If ($parts>0)
			[ItemWarehouse:117]warehouse:3:=aText1{1}
			If ($parts>1)
				[ItemWarehouse:117]aisle:16:=aText1{2}
				If ($parts>2)
					[ItemWarehouse:117]column:17:=aText1{3}
					If ($parts>3)
						[ItemWarehouse:117]shelf:18:=aText1{4}
						If ($parts>4)
							[ItemWarehouse:117]bin:19:=aText1{5}
							////  CHOPPED  AL_UpdateFields (eItemWarehouse;2)
						End if 
					End if 
				End if 
			End if 
		End if 
		ARRAY TEXT:C222(aText1; 0)
End case 
ALProEvt:=0