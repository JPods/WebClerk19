C_LONGINT:C283(bdCash)
TRACE:C157




QUERY:C277([DCash:62]; [DCash:62]tableApply:2=Table:C252(->[Invoice:26]); *)
QUERY:C277([DCash:62];  & [DCash:62]docApply:3=[Invoice:26]invoiceNum:2)
CREATE SET:C116([DCash:62]; "Current")
QUERY:C277([DCash:62]; [DCash:62]tableReceive:8=Table:C252(->[Invoice:26]); *)
QUERY:C277([DCash:62];  & ; [DCash:62]docReceive:4=[Invoice:26]invoiceNum:2)
CREATE SET:C116([DCash:62]; "New")
UNION:C120("New"; "Current"; "New")
USE SET:C118("New")
CLEAR SET:C117("New")
CLEAR SET:C117("Current")
ProcessTableOpen(Table:C252(->[DCash:62])*-1)

If (False:C215)
	QUERY:C277([DCash:62]; [DCash:62]tableApply:2=Table:C252(->[Invoice:26]); *)
	QUERY:C277([DCash:62];  & [DCash:62]docApply:3=[Invoice:26]invoiceNum:2)
	$ptTable:=ptCurTable
	ptCurTable:=(->[DCash:62])
	Srch_SetBefore("Union")
	QUERY:C277([DCash:62]; [DCash:62]tableReceive:8=Table:C252(->[Invoice:26]); *)
	QUERY:C277([DCash:62];  & ; [DCash:62]docReceive:4=[Invoice:26]invoiceNum:2)
	Srch_SetEnd("Union")
	ptCurTable:=$ptTable
	ProcessTableOpen(Table:C252(->[DCash:62])*-1)
End if 