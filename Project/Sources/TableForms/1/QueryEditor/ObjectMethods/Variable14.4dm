If (False:C215)
	TCStrong_prf_v142_PictBundle
	//02/03/03.prf
	//code changes to replace PictBundle plugin
End if 
C_TEXT:C284($vName)
C_LONGINT:C283($i; $k)
If (aTmp20Str1>0)
	CONFIRM:C162("Replace pattern "+aTmp20Str1{aTmp20Str1})
	If (OK=1)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		If (Locked:C147([TallyMaster:60]))
			jAlertMessage(10011)
		Else 
			C_LONGINT:C283($i; $k; $theSize)
			$k:=Size of array:C274(aQueryValues)
			[TallyMaster:60]script:9:=vText1
			[TallyMaster:60]publish:25:=viPublish
			//02/03/03.prf
			
			//C_PICTURE(<>myBdl1)
			//<>myBdl1:=CreateBundle 
			//SetBdlPos (<>myBdl1;0)
			//PutBdlArray (<>myBdl1;aQueryBooleans)
			//PutBdlArray (<>myBdl1;aQueryFieldNames)
			//PutBdlArray (<>myBdl1;aQueryOperators)
			//PutBdlArray (<>myBdl1;aQueryValues)
			//[TallyMaster]PictField:=<>myBdl1
			
			VAR_TO_BLOB(->[TallyMaster:60]blobField:30; ->aQueryBooleans; ->aQueryFieldNames; ->aQueryOperators; ->aQueryValues)
			
			SAVE RECORD:C53([TallyMaster:60])
			UNLOAD RECORD:C212([TallyMaster:60])
			//ClearBundle (<>myBdl1)
		End if 
	End if 
End if 


