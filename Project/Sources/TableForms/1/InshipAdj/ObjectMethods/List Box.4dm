C_LONGINT:C283($error; $i; $k)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aStkSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipAdj; aStkSelect)
		doSearch:=200
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aStkSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipAdj; aStkSelect)
		//  READ WRITE([InvStack])
		GOTO RECORD:C242([InventoryStack:29]; aStkRec{aStkSelect{1}})
		ProcessTableOpen(Table:C252(->[InventoryStack:29])*-1)
		doSearch:=200
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aStkRec; ->aStkSelect)
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged    
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
C_LONGINT:C283($error)
ALProEvt:=0