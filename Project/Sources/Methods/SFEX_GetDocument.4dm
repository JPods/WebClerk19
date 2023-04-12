//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/30/21, 21:06:16
// ----------------------------------------------------
// Method: SFEX_GetDocument
// Description
// 
// Parameters
// ----------------------------------------------------


var $tableName : Text
If (Count parameters:C259=1)
	var $1; $query_o; $found_o : Object
	var $tableNum_i : Integer
	$query_o:=$1
	$tableName:=$query_o.tableName
	$tableNum_i:=ds:C1482[$query_o.tableName].getInfo().tableNumber
	Case of   // add more options for vendor and reps
		: ($query_o.tableName="Customer")
			LBDocument_ent:=ds:C1482.Document.query("customerID = :1 & tableNum= :2"; $query_o.customerID; $tableNum_i)
		Else 
			LBDocument_ent:=ds:C1482.Document.query("idNumTask = :1 "; $query_o.idNumTask)
	End case 
	// $0:="Records: "+String(LBDocument_ent.length)
Else 
	If (process_o#Null:C1517)
		$tableName:=process_o.dataClassName
		$tableNum_i:=ds:C1482[process_o.dataClassName].getInfo().tableNumber
		Case of   // add more options for vendor and reps
			: (process_o.dataClassName="Customer")
				LBDocument_ent:=ds:C1482.Document.query("customerID = :1 & tableNum= :2"; process_o.cur.customerID; $tableNum_i)
			Else 
				LBDocument_ent:=ds:C1482.Document.query("idNumTask = :1 "; process_o.cur.idNumTask)
		End case 
	End if 
End if 

If (<>viDebugMode>410)
	ConsoleLog($tableName+": SFEX_GetDocument: LBDocument_ent.length: "+String:C10(LBDocument_ent.length))
End if 