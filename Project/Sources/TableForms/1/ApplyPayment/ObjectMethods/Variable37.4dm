C_LONGINT:C283($i)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aInvSelRec; 0)
		//  CHOPPED  $error:=AL_GetSelect(eIvc2Pay; aInvSelRec)
		aInvoices:=aInvSelRec{1}  //used in credit invoice, possibly others
		//    //  CHOPPED  $error:=AL_GetSelect (eIvc2Pay;aRayLines)   
		doSearch:=20
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aInvSelRec; 0)
		//  CHOPPED  $error:=AL_GetSelect(eIvc2Pay; aInvSelRec)
		aInvoices:=aInvSelRec{1}  //used in credit invoice, possibly others    
		GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvSelRec{1}})
		LOAD RECORD:C52([Invoice:26])
		If (Locked:C147([Invoice:26]))
			LockedNotice(->[Invoice:26])
		Else 
			ProcessTableOpen(Table:C252(->[Invoice:26])*-1)
			//CREATE SET([Invoice];"Current")
			//MODIFY RECORD([Invoice])
			//USE SET("Current")
			//CLEAR SET("Current")
			////  //  CHOPPED FillInvArrays (eIvc2Pay)//no doSearch update is in procedure
		End if 
		
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All
		AL_CmdAll(->aInvRecs; ->aInvSelRec)
		doSearch:=20
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged    
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0