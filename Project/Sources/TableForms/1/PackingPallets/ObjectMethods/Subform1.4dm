C_LONGINT:C283($error; $i; $k)
Case of 
	: (Size of array:C274(aPKUniqueID)=0)  //drop out if no arrays
		//  : (ALProEvt=0)
	: (ALProEvt=1)
		//TRACE
		ARRAY LONGINT:C221(aShipSel; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		$k:=Size of array:C274(aShipSel)
		PKContentsBox
	: (ALProEvt=2)
		TRACE:C157
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		PKContentsBox
		
		KeyModifierCurrent
		If (OptKey=0)
			jSetFromArray(->[LoadTag:88]; ->aPKUniqueID; ->aShipSel; ->[LoadTag:88]idNum:1)
		Else 
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{aShipSel{1}})
		End if 
		ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aoLineAction; ->aRayLines)
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		
		
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0
C_LONGINT:C283($error)