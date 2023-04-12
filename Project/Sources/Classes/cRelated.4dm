
// Modified by: Bill James (2022-05-24T05:00:00Z)
// Method: cRelated
// Description 
// Parameters
// ----------------------------------------------------
Class constructor($dataClassName : Text)
	var $list : Text
	This:C1470.dataClassName:=$dataClassName
	This:C1470.related:=New object:C1471
	Case of 
		: ($dataClassName="Customer")
			$list:="Order,OrderLine,Proposal,ProposalLine,Invoice,InvoiceLine,Payment,Project,Profile,Document,QA,Service,Contact,RemoteUser"
		: ($dataClassName="Contact")
			$list:="Customer,RemoteUser"
		: ($dataClassName="Vendor")
			$list:="POLine,PO,Profile,Document,QA,Service,Contact"
		: ($dataClassName="Order")
			$list:="OrderLine,POLine,PO,Profile,Document,QA,Service,Time,WODraw,WorkOrder,dInventory,Contact"
		: ($dataClassName="Invoice")
			$list:="Order,OrderLine,InvoiceLine,Profile,Document,QA,Service,DInventory,DCash,Contact"
		: ($dataClassName="Payment")
			$list:="Order,Invoice,DCash"
		: ($dataClassName="Proposal")
			$list:="Customer,Contact,ProposalLine,Profile,Document,QA,Service,Contact"
		: ($dataClassName="PO")
			$list:="Vendor,POLine,Profile,Document,QA,Service,Contact"
		: ($dataClassName="Project")
			$list:="PO,Order,Invoice,Proposal,Service,Contact,Customer,Vendor"
		: ($dataClassName="Rep")
			$list:="Order,Invoice,Proposal,Service,Contact,Customer,Territory,Quota"
		: ($dataClassName="Item")
			$list:="ItemModifier,ItemSerial,ItemSiteBucket,ItemSpec,ItemXRef,DInventory"
	End case 
	If ($list#"")
		var $c : Collection
		var $tableName : Text
		$c:=Split string:C1554($list; ";")
		For each ($tableName; $c)
			This:C1470.related[$tableName]:=New object:C1471(\
				"ents"; New object:C1471; \
				"cur"; New object:C1471; \
				"sel"; New object:C1471; \
				"pos"; -1)
		End for each 
	End if 
	
Function setData($dataClassName : Text)
	var $key : Variant
	var $list : Text
	Case of 
		: ($dataClassName="Customer")
			$list:="Order,OrderLine,Proposal,ProposalLine,Invoice,InvoiceLine,Payment,Project,Profile,Document,QA,Service,Contact,RemoteUser"
			This:C1470.Order.ents:=ds:C1482.Order.query("customerID = :1"; entry_o.customerID)
			This:C1470.OrderLine.ents:=ds:C1482.OrderLine.query("customerID = :1"; entry_o.customerID)
			This:C1470.Proposal.ents:=ds:C1482.Proposal.query("customerID = :1"; entry_o.customerID)
			This:C1470.ProposalLine.ents:=ds:C1482.ProposalLine.query("customerID = :1"; entry_o.customerID)
			This:C1470.Invoice.ents:=ds:C1482.Invoice.query("customerID = :1"; entry_o.customerID)
			This:C1470.InvoiceLine.ents:=ds:C1482.InvoiceLine.query("customerID = :1"; entry_o.customerID)
			This:C1470.Payment.ents:=ds:C1482.Payment.query("customerID = :1"; entry_o.customerID)
			This:C1470.Profile.ents:=ds:C1482.Profile.query("customerID = :1"; entry_o.customerID)
			This:C1470.Document.ents:=ds:C1482.Document.query("customerID = :1"; entry_o.customerID)
			This:C1470.QA.ents:=ds:C1482.QA.query("customerID = :1"; entry_o.customerID)
			This:C1470.Service.ents:=ds:C1482.Service.query("customerID = :1"; entry_o.customerID)
			This:C1470.Contact.ents:=ds:C1482.Contact.query("customerID = :1"; entry_o.customerID)
			This:C1470.RemoteUser.ents:=ds:C1482.RemoteUser.query("customerID = :1"; entry_o.customerID)
			
		: ($dataClassName="Contact")
			$list:="Customer,RemoteUser"
		: ($dataClassName="Vendor")
			$list:="POLine,PO,Profile,Document,QA,Service,Contact"
		: ($dataClassName="Order")
			$list:="Customer,OrderLine,POLine,PO,Profile,Document,QA,Service,Time,WODraw,WorkOrder,dInventory,Contact"
			This:C1470.Customer.ents:=ds:C1482.Customer.query("customerID = :1"; entry_o.customerID)
			This:C1470.OrderLine.ents:=ds:C1482.OrderLine.query("idNumOrder = :1"; entry_o.idNum)
			This:C1470.Proposal.ents:=ds:C1482.Proposal.query("idNumOrder = :1"; entry_o.idNum)
			This:C1470.Invoice.ents:=ds:C1482.Invoice.query("idNumOrder = :1"; entry_o.idNum)
			This:C1470.Payment.ents:=ds:C1482.Payment.query("customerID = :1"; entry_o.idNum)
			This:C1470.Document.ents:=ds:C1482.Document.query("idNumTask = :1"; entry_o.idNumTask)
			This:C1470.QA.ents:=ds:C1482.QA.query("idNumTask = :1"; entry_o.idNumTask)
			This:C1470.Service.ents:=ds:C1482.Service.query("idNumTask = :1"; entry_o.idNumTask)
			This:C1470.Contact.ents:=ds:C1482.Contact.query("idContactBill = :1 | idContactShip = :2"; entry_o.idContactBill; entry_o.idContactShip)
			
		: ($dataClassName="Contact")
			
			
			
		: ($dataClassName="Invoice")
			$list:="Order,OrderLine,InvoiceLine,Profile,Document,QA,Service,DInventory,DCash,Contact"
		: ($dataClassName="Payment")
			$list:="Order,Invoice,DCash"
		: ($dataClassName="Proposal")
			$list:="Customer,Contact,ProposalLine,Profile,Document,QA,Service,Contact"
		: ($dataClassName="PO")
			$list:="Vendor,POLine,Profile,Document,QA,Service,Contact"
		: ($dataClassName="Project")
			$list:="PO,Order,Invoice,Proposal,Service,Contact,Customer,Vendor"
		: ($dataClassName="Rep")
			$list:="Order,Invoice,Proposal,Service,Contact,Customer,Territory,Quota"
		: ($dataClassName="Item")
			$list:="ItemModifier,ItemSerial,ItemSiteBucket,ItemSpec,ItemXRef,DInventory"
	End case 
	
Function defineRelated($tableName : Text; $need_o : Object)
	This:C1470[$tableName]:=New object:C1471(\
		"ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1)
	
Function setDataOne($data : Object)
	If ($data.length>0)
		This:C1470.ents:=$data
		This:C1470.cur:=This:C1470.ents[0]
		This:C1470.sel:=This:C1470.ents[0]
		This:C1470.pos:=1
	Else 
		This:C1470.ents:=New object:C1471
		This:C1470.cur:=New object:C1471
		This:C1470.sel:=New object:C1471
		This:C1470.pos:=0
	End if 
	
	