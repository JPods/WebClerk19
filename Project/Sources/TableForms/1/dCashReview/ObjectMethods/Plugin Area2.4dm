C_LONGINT:C283($error; $incLines; $cntLines)
Case of 
	: (ALProEvt=-2)
	: (ALProEvt=-1)
	: (ALProEvt=0)
	: (ALProEvt=1)
		//Single Click
		ARRAY LONGINT:C221(adCashLinesSelect; 0)
		
		
		//  CHOPPED  $error:=AL_GetSelect(eCashLedger; adCashLinesSelect)
		////  CHOPPED  AL_GetCellValue (eSyncSelection;aSyncRecs{1};5;$tData)
		//QUERY([SyncRelationship];[SyncRelationship]UniqueID=Num($tData))
		
		
		
		////  CHOPPED  AL_UpdateFields (eSyncSelection;2)
	: (ALProEvt=2)
		
End case 
ALProEvt:=0