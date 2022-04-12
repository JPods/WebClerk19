//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($clearHardSr)
If (aSyncCnt{aSyncCnt}>0)
	CREATE RECORD:C68(aSyncFilePt{aSyncCnt}->)
	RECEIVE RECORD:C79(aSyncFilePt{aSyncCnt}->)
	$clearSoftSr:=SyncSrUniqSoft
	SyncLoadArray(aSyncFilePt{aSyncCnt}; aSyncCnt; ->aText2)
	vi6:=0
	vi7:=0
	vi8:=0
	If ($clearSoftSr)
		For ($i; 1; Size of array:C274(aText3))
			aText3{$i}:=""
			aText1{$i}:=""
		End for 
	Else 
		ArrayCompare(->aText1; ->aText2; ->aText3)
	End if 
	For ($i; 1; Size of array:C274(aSyncChoose))
		aSyncChoose{$i}:=""
	End for 
	If (vi6>0)
		aSyncChoose{vi6}:="*"
		If (vi7>0)
			aSyncChoose{vi7}:="*"
			If (vi8>0)
				aSyncChoose{vi8}:="*"
			End if 
		End if 
	End if 
	vText1:=""
End if 