//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/14/10, 22:11:20
// ----------------------------------------------------
// Method: P_vHereEnd
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(rptRecNum)
C_BOOLEAN:C305($rebuildAreaList)
$rebuildAreaList:=True:C214

If (Records in set:C195("P_Current")>1)
	USE SET:C118("P_Current")
	CLEAR SET:C117("P_Current")
	booSorted:=False:C215
	$currentRecNum:=Record number:C243(ptCurTable->)
	If ((rptRecNum#$currentRecNum) & (rptRecNum#-3))  // Modified by: williamjames (110512) added check so new record would not cance.
		jCancelButton
		$rebuildAreaList:=False:C215
	End if 
End if 
RelatedRelease  //should this be added
Set_Window_Title
If ((ptCurTable=(->[Order:3])) | (ptCurTable=(->[Invoice:26])) | (ptCurTable=(->[Proposal:42])) | (ptCurTable=(->[PO:39])))
	If ($rebuildAreaList)
		HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
		Exch_FillRays
		Case of   //always rebuild arrays  
			: (ptCurTable=(->[Order:3]))
				OrdLnFillRays
				
				If (eOrdList>0)
					//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
				End if 
				If (eOrdLn2Pos>0)
					//  --  CHOPPED  AL_UpdateArrays(eOrdLn2Pos; -2)
				End if 
			: (ptCurTable=(->[Invoice:26]))
				
				IvcLnFillRays  //vLineCnt set if no order
				
				If (eIvcList>0)
					//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
				End if 
			: (ptCurTable=(->[Proposal:42]))
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
				PpLnFillRays(Records in selection:C76([ProposalLine:43]))
				If (ePropList>0)
					//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
				End if 
			: (ptCurTable=(->[PO:39]))
				QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
				PoLnFillRays(Records in selection:C76([POLine:40]))
				If (ePoList>0)
					//  --  CHOPPED  AL_UpdateArrays(ePoList; -2)
				End if 
		End case 
	End if 
End if 