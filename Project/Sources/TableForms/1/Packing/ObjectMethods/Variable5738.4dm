KeyModifierCurrent
If ((cmdKey=1) & (OptKey=0) & (ShftKey=1))
	C_LONGINT:C283($i; $k; $w; $incLoadItem; $cntLoadItem; $incPK; $cntPK; $incInvoice; $cntInvoice)
	$cntPK:=Size of array:C274(aShipSel)
	If ($cntPK>0)
		CREATE EMPTY SET:C140([Invoice:26]; "Current")
		For ($incPK; 1; $cntPK)
			If (aPKInvoiceNum{$incPK}>0)
				QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=aPKInvoiceNum{aShipSel{$incPK}})
				ADD TO SET:C119([Invoice:26]; "Current")
			End if 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		PKInvoiceFillArrays(Records in selection:C76([Invoice:26]); 0; 0; eInvoiceList)  //eInvoiceList)
	End if 
	
End if 