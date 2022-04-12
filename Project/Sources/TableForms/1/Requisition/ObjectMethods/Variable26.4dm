KeyModifierCurrent
If (OptKey=0)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum+"@")
	Rq_ItemFillRay(Records in selection:C76([Item:4]))
	QUERY:C277([Requisition:83]; [Requisition:83]itemNum:38=pPartNum+"@")
	Rq_FillArrays(Records in selection:C76([Requisition:83]))
Else 
	QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=pPartNum+"@")
	Rq_ItemFillRay(Records in selection:C76([Item:4]))
	QUERY:C277([Requisition:83]; [Requisition:83]vendorItem:45=pPartNum+"@")
	Rq_FillArrays(Records in selection:C76([Requisition:83]))
End if 
//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
//  --  CHOPPED  AL_UpdateArrays(eReqs; -2)