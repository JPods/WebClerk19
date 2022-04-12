ARRAY REAL:C219($woQty; 0)
CREATE SET:C116([WorkOrder:66]; "current")
vR1:=Records in selection:C76([WorkOrder:66])
vR2:=0
vR3:=0
vR4:=0
SELECTION TO ARRAY:C260([WorkOrder:66]QtyOrdered:13; $woQty)
$k:=Records in selection:C76([WorkOrder:66])
C_LONGINT:C283($i; $k)
For ($i; 1; $k)
	vR2:=vR2+$woQty{$i}
End for 
USE SET:C118("UserSet")
vR1:=Records in selection:C76([WorkOrder:66])
SELECTION TO ARRAY:C260([WorkOrder:66]QtyOrdered:13; $woQty)
$k:=Records in selection:C76([WorkOrder:66])
C_LONGINT:C283($i; $k)
For ($i; 1; $k)
	vR4:=vR4+$woQty{$i}
End for 
USE SET:C118("Current")
CLEAR SET:C117("Current")