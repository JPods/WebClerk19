//%attributes = {"publishedWeb":true}
//Method: Archive_CleanOut
CONFIRM:C162("Delete Usage, dInvt,OrdLn,InvLn")
If (OK=1)
	READ WRITE:C146([Usage:5])
	ALL RECORDS:C47([Usage:5])
	DELETE SELECTION:C66([Usage:5])
	MESSAGE:C88("[dInventory]")
	READ WRITE:C146([DInventory:36])
	ALL RECORDS:C47([DInventory:36])
	DELETE SELECTION:C66([DInventory:36])
	MESSAGE:C88("[OrdLine]")
	READ WRITE:C146([OrderLine:49])
	ALL RECORDS:C47([OrderLine:49])
	DELETE SELECTION:C66([OrderLine:49])
	MESSAGE:C88("[InvLine]")
	READ WRITE:C146([InvoiceLine:54])
	ALL RECORDS:C47([InvoiceLine:54])
	DELETE SELECTION:C66([InvoiceLine:54])
End if 

REDRAW WINDOW:C456