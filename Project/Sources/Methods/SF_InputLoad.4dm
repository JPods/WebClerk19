//%attributes = {}

// Modified by: Bill James (2022-03-27T05:00:00Z)
// Method: SF_InputLoad
// Description 
// Parameters
// ----------------------------------------------------

var $1; $fromMain_o; primary_o; lines_o : Object
var $tableName : Text
$fromMain_o:=$1
$tableName:=$fromMain_o.tableName  //

If (entryEntity#Null:C1517)
	// save entity
End if 
var $entRec : Object
$entRec:=ds:C1482[$tableName].query("id = :1"; $fromMain_o.id).first()
entryEntity:=$entRec.toObject()

Case of 
	: (($tableName="Order") | ($tableName="OrderLine"))
		var OrderLineDisplayed; entryEntity : Object
		entryEntity:=ds:C1482.Order.query("id = :1"; $fromMain_o.id).first()
		
		
		// QQQents
		var LB_OrderLine : Object
		LB_OrderLine:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1)
		
		LB_OrderLine.ents:=ds:C1482.OrderLine.query("idNumOrder = :1"; entryEntity.idNum)
		
		OBJECT SET SUBFORM:C1138(*; "SF_Lines"; "OrderLine")  //; LB_OrderLine.data)
		//primary_o:=
		//Form.entryEntity.Order:=primary_o
		//lines_o:=ds.OrderLine.query("orderNum = :1 "; [Order]orderNum)
	Else 
		
End case 