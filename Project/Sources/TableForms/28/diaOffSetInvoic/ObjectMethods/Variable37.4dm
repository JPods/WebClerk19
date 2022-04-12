C_LONGINT:C283($i)
Case of 
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		ARRAY LONGINT:C221(aInvOffSetSelRec; 0)
		//  CHOPPED  $error:=AL_GetSelect(eCreditList; aInvOffSetSelRec)
		aCredIvc:=aInvOffSetSelRec{1}  //used in credit invoice, possibly others
		//    //  CHOPPED  $error:=AL_GetSelect (eIvc2Pay;aRayLines)   
		
		If (viRecordPushed>-1)  // record number of the Pushed Invoice
			If (Record number:C243([Invoice:26])#aCredRec{aCredIvc})  //add this ckeck once tested    
				GOTO RECORD:C242([Invoice:26]; aCredRec{aCredIvc})
				LOAD RECORD:C52([Invoice:26])
				If (Locked:C147([Invoice:26]))
					aCredIvc:=0
					pTotal:=0
					BEEP:C151
					BEEP:C151
					jAlertMessage(10011)
				Else 
					pPayment:=aCredUnPaid{aCredIvc}
					pDiff:=pTotal+pPayment
				End if 
			End if 
		End if 
	: (ALProEvt=2)
		
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