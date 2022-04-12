C_LONGINT:C283($theRec; $error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aPOSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(ePOs; aPOSelect)
		GOTO RECORD:C242([PO:39]; aPORecs{aPOSelect{1}})
		QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
		PoLnFillRays(Records in selection:C76([POLine:40]))
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aPOSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(ePOs; aPOSelect)
		GOTO RECORD:C242([PO:39]; aPORecs{aPOSelect{1}})
		UNLOAD RECORD:C212([POLine:40])
		ProcessTableOpen(Table:C252(->[PO:39])*-1)
		If (myOK=1)
			Ray_VarLoadRay(aPORecs; ->aPOStatus; ->[PO:39]buyer:7; ->aPOs; ->[PO:39]idNum:5; ->aVendors; ->[PO:39]vendorCompany:39; ->aPODate; ->[PO:39]dateNeeded:3; ->aPOTotal; ->[PO:39]total:24; ->aPOOpenAmt; ->[PO:39]amountBackLog:25; ->aPOAttn; ->[PO:39]attention:26)
			doSearch:=7
		End if 
		//If (curFile#File([Control]))
		//jSetCntrlPhase (0;"Selected Order "+String([Order]OrderNum;"0000
		//-0000"))
		//End if 
		TRACE:C157
		READ ONLY:C145([POLine:40])
		QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=aPOs{aPOSelect{1}})
		PoLnFillRays(Records in selection:C76([POLine:40]))
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
ALProEvt:=0