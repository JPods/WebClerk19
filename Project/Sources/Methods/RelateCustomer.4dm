//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/31/09, 11:33:40
// ----------------------------------------------------
// Method: RelateCustomer
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171213_1713 auto relate recent history
// added UNLOAD RECORD after each search to prevent locking of records.

// ### jwm ### 20171213_1447 update queries to 1 year of history to reduce loading time
C_DATE:C307($vdDateBegin)
C_LONGINT:C283($dtDateBegin)

If (process_o.tableNum=Null:C1517)
	process_o.tableNum:=STR_GetTableNumber(process_o.dataClassName)
End if 

$vdDateBegin:=Current date:C33-Storage:C1525.default.recentDays  // ### jwm ### 20171213_1713 auto relate recent history
$dtDateBegin:=DateTime_DTTo($vdDateBegin)

process_o.ents.Profile:=ds:C1482.Profile.query("tableNum = :1 & idForeign = :2"; process_o.tableNum; process_o.cur.id).orderBy("name asc")

process_o.ents.CallReport:=ds:C1482.CallReport.query("tableNum = :1 & customerID = :2 & dateDocument >= :3"; \
process_o.tableNum; process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")

process_o.ents.CommunicationDevice:=ds:C1482.CommunicationDevice.query("tableNum = :1 & customerID = :2 "; \
process_o.tableNum; process_o.cur.customerID).orderBy("deviceType")

process_o.ents.Contact:=ds:C1482.Contact.query("customerID = :1 & dateRetired = :2 "; \
process_o.cur.customerID; !00-00-00!).orderBy("nameLast asc")

//process_o.ents.DCash:=ds.DCash.query("customerIDReceive = :1 OR customerIDApply :2 AND dateDocument > :3 "; \
process_o.cur.customerID; process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")

process_o.ents.DCash:=ds:C1482.DCash.query("customerIDReceive = :1 AND dateDocument > :2 "; \
process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")


//process_o.ents.DCash:=ds.DCash.query("customerIDReceive = :1 | customerIDApply :2 & dateDocument > :3 "; \
process_o.cur.customerID; process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")

process_o.ents.Document:=ds:C1482.Document.query("customerID = :1 & idNumTask < 9 & tableNum = 2"; process_o.cur.customerID)
process_o.ents.QA:=ds:C1482.QA.query("customerID = :1 & idNumTask < 9 & tableNum = 2"; process_o.cur.customerID).orderBy("question asc")

process_o.ents.Invoice:=ds:C1482.Invoice.query("customerID = :1 & dateDocument > :2 "; \
process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")  //<>ptInvoiceDateFld


process_o.ents.ItemSerial:=ds:C1482.ItemSerial.query("customerID = :1 "; process_o.cur.customerID)

process_o.ents.Ledger:=ds:C1482.Ledger.query("customerID = :1 & dateDocument > :2 "; \
process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")  //<>ptInvoiceDateFld

process_o.ents.Order:=ds:C1482.Order.query("customerID = :1 & dateDocument > :2 "; \
process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")  //<>ptInvoiceDateFld
process_o.ents.Payment:=ds:C1482.Payment.query("customerID = :1 & dateDocument > :2 "; \
process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")  //<>ptInvoiceDateFld

process_o.ents.Proposal:=ds:C1482.Proposal.query("customerID = :1 & dateDocument > :2 "; \
process_o.cur.customerID; $vdDateBegin).orderBy("dateDocument desc")  //<>ptInvoiceDateFld

process_o.ents.Reference:=ds:C1482.Reference.query("customerID = :1"; process_o.cur.customerID)  //<>ptInvoiceDateFld

process_o.ents.RemoteUser:=ds:C1482.RemoteUser.query("customerID = :1 & tableNum = :2"; \
process_o.cur.customerID; process_o.tableNum)

process_o.ents.Service:=ds:C1482.Service.query("customerID = :1 & dtDocument>= :2"; \
process_o.cur.customerID; $dtDateBegin).orderBy("dtDocument desc")  //<>ptInvoiceDateFld


