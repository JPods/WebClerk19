C_TEXT:C284($vName)
C_LONGINT:C283($w)
If (aTmp20Str1>0)
	CONFIRM:C162("Delete search "+aTmp20Str1{aTmp20Str1})
	If (OK=1)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		If (Locked:C147([TallyMaster:60]))
			jAlertMessage(10011)
		Else 
			$w:=aTmp20Str1
			DELETE FROM ARRAY:C228(aTmp20Str1; $w)
			DELETE FROM ARRAY:C228(aTmpLong1; $w)
			DELETE RECORD:C58([TallyMaster:60])
			//  --  CHOPPED  AL_UpdateArrays(eSrchRecs; -2)
		End if 
	End if 
End if 