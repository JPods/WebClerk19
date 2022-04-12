// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/23/15, 14:05:24
// ----------------------------------------------------
// Method: [Default].DiaSearch.bRename
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($vName; $rename)
C_LONGINT:C283($i; $k)
If (aTmp20Str1>0)
	$rename:=Request:C163("Rename "+aTmp20Str1{aTmp20Str1}; aTmp20Str1{aTmp20Str1}; " Rename "; " Cancel ")
	If (OK=1)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		If (Locked:C147([TallyMaster:60]))
			jAlertMessage(10011)
		Else 
			C_LONGINT:C283($i; $k; $theSize)
			$k:=Size of array:C274(aQueryValues)
			[TallyMaster:60]script:9:=vText1
			[TallyMaster:60]name:8:=$rename
			
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
// ### jwm ### 20150223_1342
Temp_RayInit
Srch_EdBefore(eSrchPat)
myOK:=0
