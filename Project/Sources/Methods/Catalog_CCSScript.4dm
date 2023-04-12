//%attributes = {}

// Modified by: Bill James (2022-10-16T05:00:00Z)
// Method: Catalog_CCSScript
// Description 
// Parameters
// ----------------------------------------------------
var $rec_s; $rec_e : Object

$rec_s:=ds:C1482.Item.query("itemNum = :1"; line_o["Inventory ID"])