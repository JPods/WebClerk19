// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 20:56:17
// ----------------------------------------------------
// Method: Form Method: Requisition
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Outside call:C328)
		C_BOOLEAN:C305(<>vbDoQuit)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		Else 
			Rq_OutSide
		End if 
	: ((Before:C29) | (booPreNext))
		C_LONGINT:C283($k; $i)
		iLoMenu:=6
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Requisition"+"-"+Current user:C182)
		//    Pict_InputLo ([Control];1;5)//get PICT resc 21005
		ARRAY LONGINT:C221(aWoStepLns; 0)
		ARRAY LONGINT:C221(aReqLines; 0)
		ARRAY LONGINT:C221(aReqsLns; 0)
		OrdLnRays(0)
		TRACE:C157
		If ((<>vLDocFile>0) & (<>vLDocRec>-1))
			Case of 
				: (<>vLDocFile=Table:C252(->[Order:3]))
					GOTO RECORD:C242([Order:3]; <>vLDocRec)
					QUERY:C277([Requisition:83]; [Requisition:83]idNumOrder:4=[Order:3]idNum:2)
				: (<>vLDocFile=Table:C252(->[Proposal:42]))
					GOTO RECORD:C242([Proposal:42]; <>vLDocRec)
					QUERY:C277([Requisition:83]; [Requisition:83]idNumProposal:3=[Proposal:42]idNum:5)
				: (<>vLDocFile=Table:C252(->[PO:39]))
					GOTO RECORD:C242([PO:39]; <>vLDocRec)
					QUERY:C277([Requisition:83]; [Requisition:83]idNumPO:2=[PO:39]idNum:5)
				: (<>vLDocFile=Table:C252(->[Item:4]))
					TRACE:C157
			End case 
			Rq_FillArrays(Records in selection:C76([Requisition:83]))
		Else 
			Rq_FillArrays(0)
		End if 
		vDate1:=!00-00-00!
		vDate2:=!00-00-00!
		If (Before:C29)
			Rq_ALDefineOrd(eReqs)
			Rq_ALDefine(eActiveReqs)  //area; Workload screen    
		End if 
		READ ONLY:C145([Customer:2])
		READ ONLY:C145([Order:3])
		READ ONLY:C145([Invoice:26])
		READ ONLY:C145([PO:39])
		READ ONLY:C145([POLine:40])
		READ ONLY:C145([Proposal:42])
		READ ONLY:C145([ProposalLine:43])
		READ ONLY:C145([Vendor:38])
		READ ONLY:C145([OrderLine:49])
		READ ONLY:C145([InvoiceLine:54])
	Else 
		If (ptCurTable#(->[Control:1]))
			If (ptCurTable=(->[PO:39]))
				If ((Record number:C243([PO:39])>-1) & (myOK=1))
					$k:=Size of array:C274(aReqSelLns)
					For ($i; 1; $k)
						aRqPONum{aReqSelLns{$i}}:=[PO:39]idNum:5
						Rq_FillArrays(-4; aReqSelLns{$i}; 1)
						//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
					End for 
				End if 
			End if 
			myOK:=0
			jsetDuringIncl(->[Control:1])
			SET WINDOW TITLE:C213("Requisition"+"-"+Current user:C182)
			//  Pict_InputLo ([Control];1;6)//get PICT resc 21005
			// WO_FillArrays (0)
			//  Tm_FixedArray (96;4)
			////  --  CHOPPED  AL_UpdateArrays (eWorkFlow;-2)
			////  --  CHOPPED  AL_UpdateArrays (eTimeList;-2)
			// //  --  CHOPPED  AL_UpdateArrays (eOrdLines;-2)
		End if 
End case 