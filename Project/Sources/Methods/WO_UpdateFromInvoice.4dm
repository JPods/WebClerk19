//%attributes = {"publishedWeb":true}
TRACE:C157
//Method: WO_UpdateFromInvoice
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aRayLines)
READ WRITE:C146([WorkOrder:66])
For ($i; 1; $k)
	MESSAGE:C88("Processing WO "+String:C10([WorkOrder:66]woNum:29; "0000-0000"))
	If (aiLnComment{aRayLines{$i}}="WOLink@")
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=aiLocation{aRayLines{$i}})
		LOAD RECORD:C52([WorkOrder:66])
		If (Locked:C147([WorkOrder:66]))
			ALERT:C41("WO is locked:  "+String:C10([WorkOrder:66]woNum:29; "0000-0000"))
		Else 
			[WorkOrder:66]QtyOrdered:13:=aiQtyOrder{aRayLines{$i}}
			[WorkOrder:66]WOPrice:47:=aiUnitPrice{aRayLines{$i}}
			[WorkOrder:66]ItemNum:12:=aiItemNum{aRayLines{$i}}
			[WorkOrder:66]ItemDescript:34:=aiDescpt{aRayLines{$i}}
			SAVE RECORD:C53([WorkOrder:66])
		End if 
	End if 
End for 
UNLOAD RECORD:C212([WorkOrder:66])

REDRAW WINDOW:C456