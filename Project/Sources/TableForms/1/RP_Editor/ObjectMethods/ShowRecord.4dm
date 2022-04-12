
If (Size of array:C274(aSyncRecs)>0)
	C_TEXT:C284($tData; $script)
	
	//  CHOPPED  AL_GetCellValue(eSyncSelection; aSyncRecs{1}; 7; $tData)
	UNLOAD RECORD:C212([SyncRelation:103])
	
	$script:="QUERY([SyncRelation];[SyncRelation]UniqueID="+$tData+")"
	ProcessTableOpen(Table:C252(->[SyncRelation:103]); $script; "Record Passing")
End if 