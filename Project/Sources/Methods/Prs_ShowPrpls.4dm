//%attributes = {"publishedWeb":true}
//Procedure: Prs_ShowPrpls
//Noah Dykoski  December 28, 1998 / 7:10 PM
If (Application type:C494#4D Server:K5:6)
	If (vHere>1)
		PUSH RECORD:C176(ptCurTable->)
		$ptFile:=ptCurTable
	End if 
	UNLOAD RECORD:C212([Proposal:42])
	<>ptCurTable:=->[Proposal:42]
	CREATE SET:C116([Proposal:42]; "<>curSelSet")
	DB_ShowCurrentSelection(->[Proposal:42]; ""; 1; "")
	If (vHere>1)
		ptCurTable:=$ptFile
		POP RECORD:C177(ptCurTable->)
	End if 
	jrelateClrFiles
End if 