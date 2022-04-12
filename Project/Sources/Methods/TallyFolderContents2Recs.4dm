//%attributes = {"publishedWeb":true}
vi2:=Records in selection:C76([TallyResult:73])
vText:=Get_FolderName("Select folder to list contents.")
FIRST RECORD:C50([TallyResult:73])
For (vi1; 1; vi2)
	vText2:=UTListFilesinFolder(vText+[TallyResult:73]ItemNum:34+":"; True:C214; 0; " ")
	[TallyResult:73]TextBlk1:5:=vText2
	SAVE RECORD:C53([TallyResult:73])
	NEXT RECORD:C51([TallyResult:73])
End for 