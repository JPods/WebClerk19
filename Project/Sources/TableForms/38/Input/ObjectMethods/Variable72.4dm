C_LONGINT:C283(ePoLines)
C_LONGINT:C283($theRec)
C_BOOLEAN:C305(vModPoLn)
C_LONGINT:C283($poNum)
$doCalPo:=False:C215
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		//  CHOPPED  aPOLineAction:=AL_GetLine(ePoLines)
		$doCalPo:=True:C214
		GOTO RECORD:C242([POLine:40]; aPOLineAction{aPOLineAction})
		If ([POLine:40]idNumPO:1#[PO:39]idNum:5)
			QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
		End if 
	: (ALProEvt=2)
		//  CHOPPED  aPOLineAction:=AL_GetLine(ePoLines)
		KeyModifierCurrent
		If (OptKey=1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aPoItemNum{aPOLineAction})
			If (Records in selection:C76([Item:4])=1)
				ProcessTableOpen(Table:C252(->[Item:4])*-1)
				DELAY PROCESS:C323(Current process:C322; 60)
			Else 
				BEEP:C151
				BEEP:C151
			End if 
		Else 
			If (vModPoLn)
				TRACE:C157  //save line changes
			End if 
			GOTO RECORD:C242([POLine:40]; aPOLineAction{aPOLineAction})
			$poNum:=[POLine:40]idNumPO:1
			If ([POLine:40]idNumPO:1#[PO:39]idNum:5)
				QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
			End if 
			UNLOAD RECORD:C212([POLine:40])
			ProcessTableOpen(Table:C252(->[PO:39])*-1)
			DELAY PROCESS:C323(Current process:C322; 90)
			//AL_RemoveArrays (ePoLines;16;7)
			//AL_RemoveArrays (ePoLines;1;15)
			QUERY:C277([PO:39]; [PO:39]idNum:5=$poNum)
			QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=$poNum)
			PoLnFillRays(Records in selection:C76([POLine:40]))
			//POLineALDefine (ePoLines)
			TRACE:C157
			//If (myOK=1)
			//TRACE
			//doSearch:=7
		End if 
		//If (curFile#File([Control]))
		//jSetCntrlPhase (0;"Selected Order "+String([Order]OrderNum;"0000
		//-0000"))
		//End if 
		vModPoLn:=False:C215  //in case it was changed in some other file
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
ALProEvt:=0