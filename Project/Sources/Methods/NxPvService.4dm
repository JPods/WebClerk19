//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-28T06:00:00Z)
// Method: NxPvService
// Description 
// Parameters
// ----------------------------------------------------

If (process_o.cur.customerID="")
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Customer:=ds:C1482.Customer.query("customerID = :1"; process_o.cur.customerID)
End if 
If (process_o.cur.idNumOrder=0)
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Order:=ds:C1482.Order.query("idNum = :1"; process_o.cur.idNumOrder)
End if 
If (process_o.cur.idNumInvoice=0)
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Invoice:=ds:C1482.Invoice.query("idNum = :1"; process_o.cur.idNumInvoice)
End if 
If (process_o.cur.idNumProject=0)
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Project:=ds:C1482.Project.query("idNum = :1"; process_o.cur.idNumProject)
End if 
If (process_o.cur.idNumProposal=0)
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Proposal:=ds:C1482.Proposal.query("idNum = :1"; process_o.cur.idNumProposal)
End if 
If (process_o.cur.idNumTask=0)
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Document:=ds:C1482.Document.query("idNum = :1"; process_o.cur.idNumTask)
End if 
If (process_o.cur.itemNum="")
	process_o.ents.Customer:=Null:C1517
Else 
	process_o.ents.Item:=ds:C1482.Item.query("itemNum = :1"; process_o.cur.itemNum)
End if 






