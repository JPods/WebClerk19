If (False:C215)
	C_LONGINT:C283($i; $k; $w; $incLoadItem; $cntLoadItem; $incPK; $cntPK; $incInvoice; $cntInvoice)
	$cntLoadItem:=Size of array:C274(aLiLoadItemSelect)
	If ($cntLoadItem>0)
		CREATE EMPTY SET:C140([LoadTag:88]; "Current")
		For ($incLoadItem; 1; $cntLoadItem)
			If (aLiLoadTagID{$incLoadItem}>0)
				QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aLiLoadTagID{aLiLoadItemSelect{$incLoadItem}})
				ADD TO SET:C119([LoadTag:88]; "Current")
			End if 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
		//
		$cntPK:=Size of array:C274(aPKInvoiceNum)
		CREATE EMPTY SET:C140([Invoice:26]; "Current")
		For ($incPK; 1; $cntPK)
			If (aPKInvoiceNum{$incPK}>0)
				QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=aPKInvoiceNum{$incPK})
				ADD TO SET:C119([Invoice:26]; "Current")
			End if 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		PKInvoiceFillArrays(Records in selection:C76([Invoice:26]); 0; 0; eInvoiceList)  //eInvoiceList)
	End if 
End if 