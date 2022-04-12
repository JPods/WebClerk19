C_LONGINT:C283($i)
Case of 
	: (Size of array:C274(aPayRecs)=0)  //drop out if no arrays
	: (ALProEvt=0)
	: (ALProEvt=1)
		//    //  CHOPPED  $error:=AL_GetSelect (ePay2App;aRayLines)    
		//  CHOPPED  $i:=AL_GetLine(ePay2App)
		aPayInvs:=$i
		doSearch:=21
	: (ALProEvt=2)
		//  CHOPPED  $i:=AL_GetLine(ePay2App)
		aPayInvs:=$i
		GOTO RECORD:C242([Payment:28]; aPayRecs{aPayInvs})
		LOAD RECORD:C52([Payment:28])
		If (Locked:C147([Payment:28]))
			jAlertMessage(10011)
		Else 
			C_LONGINT:C283($curRec)
			$curRec:=Record number:C243([Payment:28])
			//MODIFY RECORD([Payment])
			ProcessTableOpen(Table:C252(->[Payment:28])*-1)
			If (False:C215)
				If ($curRec=Record number:C243([Payment:28]))
					Pay_UpdateRayEl($i)
				End if   //must redo invoices because of the window in the payment record      
				QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1)  //must be reset until pay & inv stop using same arrays for other invoices
				//  //  CHOPPED FillInvArrays(Records in selection([Invoice]); 0; 0; eIvc2Pay)
			End if 
		End if 
		// //  CHOPPED  $error:=AL_GetSelect (ePay2App;aRayLines)
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All
		AL_CmdAll(->aPayRecs; ->aInvSelRec)
		doSearch:=21
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged    
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0