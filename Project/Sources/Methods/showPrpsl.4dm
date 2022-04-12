//%attributes = {"publishedWeb":true}
//Procedure: showPrpsl
//Noah Dykoski  December 9, 1998 / 11:58 PM

C_LONGINT:C283($fileNum)
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
$fileNum:=0
Case of 
	: ((ptCurTable=(->[Customer:2])) & (vHere=1))
		RELATE MANY SELECTION:C340([Proposal:42]customerID:1)
	: ((ptCurTable=(->[ProposalLine:43])) & (vHere=1))
		RELATE ONE SELECTION:C349([ProposalLine:43]; [Proposal:42])
	: ((ptCurTable=(->[Order:3])) & (vHere=1))
		RELATE ONE SELECTION:C349([Order:3]; [Proposal:42])
	: ((ptCurTable=(->[Order:3])) & (vHere=2))
		CREATE SET:C116([Order:3]; "SaveRecs")
		RELATE ONE SELECTION:C349([Order:3]; [Proposal:42])
		USE SET:C118("SaveRecs")
		CLEAR SET:C117("SaveRecs")
		Prs_ShowPrpls
		$doJoin:=False:C215
	Else 
		DB_ShowByTableName("Proposal")
		$doJoin:=False:C215
End case 
If ($doJoin)
	$fileNum:=Table:C252(->[Proposal:42])*Num:C11(Records in selection:C76([Proposal:42])>0)
	If ($fileNum>0)
		ProcessTableOpen(Table:C252($fileNum))
	End if 
End if 