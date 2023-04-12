Class constructor($dataClassName : Text)
	This:C1470.dataClassName:=$dataClassName
	var $list : Text
	If (Storage:C1525.user.selectlist[$dataClassName]#Null:C1517)
		
		
		$list:=Storage:C1525.user.selectlist[$dataClassName]
		
		// add this
		// MustFixQQQZZZ: Bill James (2022-06-24T05:00:00Z)
		
	Else 
		
		//,Time,WorkOrder
		Case of 
			: ($dataClassName="Order")
				$list:="Call,Clones,Contact,Customer,Document,Invoice,InvoiceLine,"+\
					"Item,ItemSerial,ItemXRef,Payment,PO,POLine,"+\
					"QA,Service,Shipping,ItemSerial,Object"
			: ($dataClassName="Invoice")
				$list:="Document,Item,PO,POLine,QA,ItemSerial,Object"
			: ($dataClassName="Proposal")
				$list:="Document,Item,PO,POLine,QA,ItemSerial,Object"
			: ($dataClassName="Requisition")
				$list:="Document,Item,PO,POLine,QA,ItemSerial,Vendor,Object"
			: ($dataClassName="Customer")
				$list:="Document,Invoice,Order,Shipping,Proposal,Contact,History,QA,Object"
			: ($dataClassName="Vendor")
				$list:="Document,PO,Object"
			: ($dataClassName="Contact")
				$list:="Document,Object"
			: ($dataClassName="Rep")
				$list:="Order,Quota,Object"
		End case 
	End if 
	$list:=$list+",Columns,FieldValues,Metrics"
	This:C1470.list:=Split string:C1554($list; ";").orderBy()
	This:C1470.list.unshift("  --  ")
	This:C1470.list.unshift("Selection")
	
	// HOWTO: Collection to array
	