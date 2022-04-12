KeyModifierCurrent
$myOK:=0
C_LONGINT:C283($myOK)
If (OptKey=0)
	CONFIRM:C162("Post Item Spec to this record")
	$myOK:=1
Else 
	CONFIRM:C162("Post Parent Item Spec to this record")
	$myOK:=2
End if 
If ($myOK=1)
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Requisition:83]ItemNum:38)
	If (Records in selection:C76([ItemSpec:31])=1)
		[Requisition:83]CurSpec:21:=[ItemSpec:31]Specification:2+<>vCR+<>vCR+"*************"+<>vCR+<>vCR+[Requisition:83]CurSpec:21
	End if 
End if 
If ($myOK=2)
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Requisition:83]ItemParent:40)
	If (Records in selection:C76([ItemSpec:31])=1)
		[Requisition:83]CurSpec:21:=[ItemSpec:31]Specification:2+<>vCR+<>vCR+"*************"+<>vCR+<>vCR+[Requisition:83]CurSpec:21
	End if 
End if 