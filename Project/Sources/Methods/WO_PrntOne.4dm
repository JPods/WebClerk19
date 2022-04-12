//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w; $e)
ARRAY LONGINT:C221(aPOs; 0)
ARRAY TEXT:C222(a1Str35; 0)
ARRAY TEXT:C222(a2Str35; 0)
ARRAY TEXT:C222(a3Str35; 0)
QUERY:C277([Item:4]; [Item:4]itemNum:1=[WorkOrder:66]ItemNum:12)
If ([Item:4]specId:62="")
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]itemNum:1)
Else 
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]specId:62)
End if 
QUERY:C277([WorkOrderTask:67]; [WorkOrderTask:67]ItemNum:1=[WorkOrder:66]ItemNum:12)
ORDER BY:C49([WorkOrderTask:67]; [WorkOrderTask:67]Sequence:2)
If (Records in selection:C76([WorkOrderTask:67])>19)
	$k:=19
Else 
	$k:=Records in selection:C76([WorkOrderTask:67])
End if 
ARRAY LONGINT:C221(aPOs; $k)
ARRAY TEXT:C222(a1Str35; $k)
ARRAY TEXT:C222(a2Str35; $k)
ARRAY TEXT:C222(a3Str35; $k)
FIRST RECORD:C50([WorkOrderTask:67])
For ($i; 1; $k)
	aPOs{$i}:=[WorkOrderTask:67]Sequence:2
	a1Str35{$i}:=[WorkOrderTask:67]Action:3
	a2Str35{$i}:=[WorkOrderTask:67]Tools:4
	a3Str35{$i}:=[WorkOrderTask:67]Safety:5
	NEXT RECORD:C51([WorkOrderTask:67])
End for 
Print form:C5([WorkOrder:66]; "RptWkOrd")
PAGE BREAK:C6