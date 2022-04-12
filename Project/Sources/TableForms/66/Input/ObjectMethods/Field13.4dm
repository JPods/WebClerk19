If ([WorkOrder:66]QtyActual:14>0)
	vr1:=Round:C94([WorkOrder:66]CostActual:16/[WorkOrder:66]QtyActual:14; 2)
Else 
	vr1:=0
End if 