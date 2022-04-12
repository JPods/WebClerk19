If (<>aNameID>1)
	KeyModifierCurrent
	vText1:=<>aNameID{<>aNameID}
	QUERY:C277([Requisition:83]; [Requisition:83]nameID:9=vText1; *)
	If (OptKey=0)
		QUERY:C277([Requisition:83];  & [Requisition:83]action:10#"Completed"; *)
	End if 
	QUERY:C277([Requisition:83])
	Rq_FillArrays(Records in selection:C76([Requisition:83]))
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
Else 
	<>aNameID:=1
End if 