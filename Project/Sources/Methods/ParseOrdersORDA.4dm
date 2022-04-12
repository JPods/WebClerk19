//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/03/21, 00:17:53
// ----------------------------------------------------
// Method: ParseOrdersORDA
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($orderNum : Integer)
REDUCE SELECTION:C351([Order:3]; 0)
C_OBJECT:C1216($veSelect; $veRecord)
$veSelect:=ds:C1482.Order.query("orderNum = :1"; String:C10($orderNum))
If ($veSelect.length=1)
	$veRecord:=$veSelect.first()
End if 
