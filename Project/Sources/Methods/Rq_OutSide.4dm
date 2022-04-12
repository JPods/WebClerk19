//%attributes = {"publishedWeb":true}
If (<>vLDocFile>0)
	TRACE:C157
	If (<>vLDocFile#Table:C252(->[Item:4]))
		GOTO RECORD:C242(Table:C252(<>vLDocFile)->; <>vLDocRec)
	End if 
	Case of 
		: (<>vLDocFile=Table:C252(->[Order:3]))
			Rq_OrdLnFillRay(Size of array:C274(<>aItemLines); 3)
			//  --  CHOPPED  AL_UpdateArrays(eReqs; -2)
		: (<>vLDocFile=Table:C252(->[Proposal:42]))
			Rq_PpLnFillRay(Size of array:C274(<>aItemLnRec); 3)
			//  --  CHOPPED  AL_UpdateArrays(eReqs; -2)
		: (<>vLDocFile=Table:C252(->[PO:39]))
			Rq_PoLnFillRay(Size of array:C274(<>aItemLnRec); 3)
			//  --  CHOPPED  AL_UpdateArrays(eReqs; -2)
		: (<>vLDocFile=Table:C252(->[Item:4]))
			Rq_ItemFillRay
			//  --  CHOPPED  AL_UpdateArrays(eReqs; -2)
	End case 
	<>vLDocFile:=0
End if 