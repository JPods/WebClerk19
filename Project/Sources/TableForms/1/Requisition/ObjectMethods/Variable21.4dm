KeyModifierCurrent
QUERY:C277([Requisition:83]; [Requisition:83]vendorID:30=v2; *)
If (vDate1#!00-00-00!)
	QUERY:C277([Requisition:83];  & [Requisition:83]actionDate:7>=vDate1; *)
End if 
If (vDate2#!00-00-00!)
	QUERY:C277([Requisition:83];  & [Requisition:83]actionDate:7<=vDate2; *)
End if 
If (OptKey=0)
	QUERY:C277([Requisition:83];  & [Requisition:83]action:10#"Completed"; *)
End if 
QUERY:C277([Requisition:83])
Rq_FillArrays(Records in selection:C76([Requisition:83]))
//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)