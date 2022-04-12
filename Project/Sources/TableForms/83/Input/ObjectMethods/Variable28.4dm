If (Records in selection:C76([Order:3])#0)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[Requisition:83]orderNum:4)
	If (Records in selection:C76([Order:3])=1)
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		$k:=Records in selection:C76([OrderLine:49])
		FIRST RECORD:C50([OrderLine:49])
		C_LONGINT:C283($i; $k)
		$i:=0
		While ($i<$k)
			$i:=$i+1
			If ([OrderLine:49]lineNum:3=[Requisition:83]OrderLineID:36)
				$i:=$k+1
				Case of 
					: ([Requisition:83]ItemNum:38=[Requisition:83]ItemParent:40)
						vR1:=[OrderLine:49]qtyOrdered:6
					: ([Requisition:83]ItemParent:40#"")
						QUERY:C277([BOM:21]; [BOM:21]ItemNum:1=[Requisition:83]ItemParent:40; *)
						QUERY:C277([BOM:21];  & [BOM:21]ChildItem:2=[Requisition:83]ItemNum:38)
						Case of 
							: (Records in selection:C76([BOM:21])=1)
								[Requisition:83]CurExtendedQty:42:=[OrderLine:49]qtyOrdered:6*[BOM:21]QtyInAssembly:3
							: (Records in selection:C76([BOM:21])>1)
								FIRST RECORD:C50([BOM:21])
								ALERT:C41("There are multiple BOM records matching this search.")
								[Requisition:83]CurExtendedQty:42:=[OrderLine:49]qtyOrdered:6*[BOM:21]QtyInAssembly:3
							Else 
								BEEP:C151
								BEEP:C151
						End case 
					Else 
						[Requisition:83]CurExtendedQty:42:=1
				End case 
			End if 
		End while 
		REDUCE SELECTION:C351([OrderLine:49]; 0)
		REDUCE SELECTION:C351([BOM:21]; 0)
		If ($i=$k)
			ALERT:C41("Order Line not found.")
		End if 
	End if 
End if 
