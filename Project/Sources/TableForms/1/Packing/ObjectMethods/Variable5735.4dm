If (False:C215)
	C_LONGINT:C283($i; $k; $w; $incLoadItem; $cntLoadItem; $incPK; $cntPK; $incInvoice; $cntInvoice)
	$k:=Size of array:C274(aoLnSelect)
	If ($k>0)
		CREATE EMPTY SET:C140([LoadItem:87]; "Current")
		For ($i; 1; $k)
			If (aOQtyShip{aoLnSelect{$i}}>0)
				QUERY:C277([LoadItem:87]; [LoadItem:87]idNumOrder:2=[Order:3]idNum:2; *)
				QUERY:C277([LoadItem:87];  & [LoadItem:87]lineid:5=aoUniqueID{aoLnSelect{$i}})
				SetAddTo(->[LoadItem:87]; "Current")
			End if 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		LT_FillArrayLoadItems(Records in selection:C76([LoadItem:87]))
		//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		
		CREATE EMPTY SET:C140([LoadTag:88]; "Current")
		$cntLoadItem:=Size of array:C274(aLiLoadTagID)
		For ($incLoadItem; 1; $cntLoadItem)
			If (aLiLoadTagID{$incLoadItem}>0)
				QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aLiLoadTagID{$incLoadItem})
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