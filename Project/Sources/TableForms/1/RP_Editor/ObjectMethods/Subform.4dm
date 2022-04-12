C_LONGINT:C283($error; $incLines; $cntLines)
Case of 
	: (ALProEvt=-2)
	: (ALProEvt=-1)
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		//Single Click  // or double
		
		C_LONGINT:C283(viSelectedRecNum)
		ARRAY LONGINT:C221(aSyncRecs; 0)
		ARRAY LONGINT:C221($aUniqIds; 0)
		
		//  CHOPPED  $error:=AL_GetSelect(eSyncSelection; aSyncRecs)
		//  CHOPPED  AL_GetCellValue(eSyncSelection; aSyncRecs{1}; 7; $tData)
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]idNum:1=Num:C11($tData))
		viSelectedRecNum:=Num:C11($tData)
		OBJECT SET ENABLED:C1123(B31; (viSelectedRecNum>-1))
		//LOAD RECORD([SyncRelationship])
		
		RP_LoadVariablesRelationship
		
		// because this is a record list, it is necessary to reestablish the general query
		// ### bj ### 20181028_1523
		// there has to be a better way. Upgrade at some time
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]active:17=True:C214)
		//  CHOPPED  AL_UpdateFields(eSyncSelection; 2)
		
		
		//  CHOPPED  AL_UpdateFields(eSyncSelection; 2)
	: (ALProEvt=2)  // not called see above
		//Single Click
		
		ARRAY LONGINT:C221(aSyncRecs; 0)
		ARRAY LONGINT:C221($aUniqIds; 0)
		
		//  CHOPPED  $error:=AL_GetSelect(eSyncSelection; aSyncRecs)
		//  CHOPPED  AL_GetCellValue(eSyncSelection; aSyncRecs{1}; 7; $tData)
		//  QUERY([SyncRelation];[SyncRelation]UniqueID=Num($tData))
		
		RP_LoadVariablesRelationship
		
		
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]active:17=True:C214)
		//  CHOPPED  AL_UpdateFields(eSyncSelection; 2)
End case 
ALProEvt:=0