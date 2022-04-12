//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/02/20, 20:08:23
// ----------------------------------------------------
// Method: IndexByNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------

$INDEX_ID:="1123"  // it's a string!
$found_l:=0  // count of records found
Begin SQL
	SELECT Count(*)
	FROM _USER_IND_COLUMNS
	WHERE INDEX_ID = :$INDEX_ID
	INTO :$found_l;
End SQL
ALERT:C41(String:C10($found_l))