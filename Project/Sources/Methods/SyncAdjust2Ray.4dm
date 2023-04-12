//%attributes = {"publishedWeb":true}
//Procedure: SyncEchoUpdate
C_POINTER:C301($ptCurFile)
$ptCurFile:=aSyncFilePt{aSyncCnt}
Case of 
	: ($ptCurFile=(->[Contact:13]))
		SyncChckEchoRay(->[Customer:2]; ->[Contact:13]; ->[Contact:13]customerID:1; ->vText2)
		
		//
	: ($ptCurFile=(->[Customer:2]))
		
		//
	: ($ptCurFile=(->[Service:6]))
		SyncChckEchoRay(->[Customer:2]; ->[Service:6]; ->[Service:6]customerID:1; ->[Service:6]comment:11)
		SyncChckEchoRay(->[Order:3]; ->[Service:6]; ->[Service:6]idNumOrder:22; ->[Service:6]comment:11)
		SyncChckEchoRay(->[Invoice:26]; ->[Service:6]; ->[Service:6]idNumInvoice:23; ->[Service:6]comment:11)
		SyncChckEchoRay(->[Proposal:42]; ->[Service:6]; ->[Proposal:42]idNum:5; ->[Service:6]comment:11)
		
		//
	: ($ptCurFile=(->[Proposal:42]))
		SyncChckEchoRay(->[Customer:2]; ->[Proposal:42]; ->[Proposal:42]customerID:1; ->[Proposal:42]comment:36)
		
		//PackUnText ([Proposal]Comment;[PrpLine];219;[PrpLine]ProposalKey
		//;[Proposal]ProposalNum)
		//
	: ($ptCurFile=(->[Order:3]))
		SyncChckEchoRay(->[Customer:2]; ->[Order:3]; ->[Order:3]customerID:1; ->[Order:3]commentProcess:12)
		
		//
	: ($ptCurFile=(->[Invoice:26]))
		SyncChckEchoRay(->[Customer:2]; ->[Invoice:26]; ->[Invoice:26]customerID:3; ->[Invoice:26]comment:43)
		SyncChckEchoRay(->[Order:3]; ->[Invoice:26]; ->[Invoice:26]idNumOrder:1; ->[Invoice:26]comment:43)
		
End case 
//save after this procedure