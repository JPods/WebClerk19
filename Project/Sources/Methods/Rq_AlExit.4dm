//%attributes = {"publishedWeb":true}
//Procedure: Ord_WFALCBExit
//January 2, 1996//TRACE
//called in AL Definitions
C_BOOLEAN:C305($0)  //Entry Valid (True) or Entry Rejected (False)
C_LONGINT:C283($1)  //Area Name
C_LONGINT:C283($2)  //Action that Caused Entry Finished
$0:=True:C214
C_LONGINT:C283($col; $row)
C_LONGINT:C283(eWorkFlow; eOrdWos)
Case of 
	: ($1=eActiveReqs)
		//  CHOPPED  AL_GetCurrCell($1; $col; $row)
		READ WRITE:C146([Requisition:83])
		Rq_FillArrays(-4; aReqSelLns{1})
		//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
End case 