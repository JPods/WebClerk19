//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i; $dtCurrent)
$dtCurrent:=DateTime_Enter
QUERY:C277([TallyMaster:60]; [TallyMaster:60]dtNextRun:12>0; *)
QUERY:C277([TallyMaster:60]; [TallyMaster:60]dtNextRun:12<=$dtCurrent)
$k:=Records in selection:C76([TallyMaster:60])
FIRST RECORD:C50([TallyMaster:60])
For ($i; 1; $k)
	LOAD RECORD:C52([TallyMaster:60])
	If (Not:C34(Locked:C147([TallyMaster:60])))
		ExecuteText(0; [TallyMaster:60]build:6)
		[TallyMaster:60]dtNextStart:10:=[TallyMaster:60]dtNextStart:10+[TallyMaster:60]duration:11
		SAVE RECORD:C53([TallyMaster:60])
		NEXT RECORD:C51([TallyMaster:60])
	End if 
End for 
UNLOAD RECORD:C212([TallyMaster:60])