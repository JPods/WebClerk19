//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-02T00:00:00, 11:45:20
// ----------------------------------------------------
// Method: PK_ReassignLoadTagToInvoice
// Description
// Modified: 06/02/17
// 
// 
//
// Parameters
// ----------------------------------------------------

// DANGEROUS --  Purposefully changing LoadTags and LoadItems to an invoices WITHOUT packing them on that Invoice.

C_LONGINT:C283($cntInv; $incTags; $cntTags; $invNum)

CONFIRM:C162("Assign Invoice# to these LoadTags and their Load Items?")
If (OK=1)
	$cntInv:=Size of array:C274(aInvoiceRecSel)
	$cntTags:=Size of array:C274(aShipSel)
	Case of 
		: ($cntInv=0)
			ALERT:C41("No invoice selected.")
		: ($cntInv>1)
			ALERT:C41("Multiple invoices selected.")
		: ($cntTags=0)
			ALERT:C41("No LoadTags selected.")
		Else 
			$invNum:=aInvoices{aInvoiceRecSel{1}}
			For ($incTags; 1; $cntTags)
				QUERY:C277([LoadTag:88]; [LoadTag:88]idUnique:1=aPKUniqueID{aShipSel{$incTags}})
				If (Locked:C147([LoadTag:88]))
					ALERT:C41("LoadTag locked.")
				Else 
					aPKInvoiceNum{aShipSel{$incTags}}:=$invNum
					[LoadTag:88]invoiceNum:19:=$invNum
					QUERY:C277([LoadItem:87]; [LoadItem:87]LoadTagID:8=[LoadTag:88]idUnique:1)
					READ WRITE:C146([LoadItem:87])
					APPLY TO SELECTION:C70([LoadItem:87]; [LoadItem:87]invoiceNum:14:=[LoadTag:88]invoiceNum:19)
					SAVE RECORD:C53([LoadTag:88])
				End if 
			End for 
			UNLOAD RECORD:C212([LoadTag:88])
			REDUCE SELECTION:C351([LoadTag:88]; 0)
			UNLOAD RECORD:C212([LoadItem:87])
			REDUCE SELECTION:C351([LoadItem:87]; 0)
	End case 
End if 
