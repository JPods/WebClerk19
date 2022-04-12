//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/14/06, 09:23:54
// ----------------------------------------------------
// Method: LoadTag_FindByCustPO
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($theTag)
$theTag:=Request:C163("Query LoadTags by Customer's PONumber.")
If (OK=1)
	$theTag:=$theTag+"@"
	//QUERY([LoadTag];[LoadTag]CustPONum=[Order]CustPONum=[LoadTag]CustPONum)
	QUERY:C277([LoadTag:88]; [LoadTag:88]customerPO:37=$theTag)
	ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)
End if 