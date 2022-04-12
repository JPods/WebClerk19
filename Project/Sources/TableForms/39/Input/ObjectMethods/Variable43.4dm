C_BOOLEAN:C305($doPush)
$doPush:=False:C215
TRACE:C157

DropShipFill("PO"; "Customer")
If (Records in selection:C76([Vendor:38])>0)
	REDUCE SELECTION:C351([Vendor:38]; 0)
End if 


