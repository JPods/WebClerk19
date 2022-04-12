TRACE:C157
C_LONGINT:C283($k; $i)
C_BOOLEAN:C305(haveReceiptID; vbSpreadFreight)
$k:=Size of array:C274(aPoRcptSelect)
If ($k>0)
	If (vsVendorInvoiceNum="")
		ALERT:C41("Enter Vendor Invoice ID.")
	Else 
		//CONFIRM("Complete Selected Receipts with Invoice: "+vsVendorInvoiceNum
		//+"?")
		//If (OK=1)
		For ($i; 1; $k)
			aPoRcptInvNum{aPoRcptSelect{$i}}:=vsVendorInvoiceNum
			If (vdVendorInvoiceDate=!00-00-00!)
				vdVendorInvoiceDate:=Current date:C33
			End if 
			aPoRcptInvDate{aPoRcptSelect{$i}}:=vdVendorInvoiceDate
			QUERY:C277([POReceipt:95]; [POReceipt:95]idNum:1=aPoRcptID{aPoRcptSelect{$i}})
			PoReceiptFillRay(-5; aPoRcptSelect{$i})
			SAVE RECORD:C53([POReceipt:95])
		End for 
		UNLOAD RECORD:C212([POReceipt:95])
		//
		//  --  CHOPPED  AL_UpdateArrays(eReceipts; -2)
		viVert:=aPoRcptSelect{1}
		// -- AL_SetScroll(eReceipts; viVert; viHorz)
		// -- AL_SetSelect(eReceipts; aPoRcptSelect)
		//End if 
	End if 
End if 