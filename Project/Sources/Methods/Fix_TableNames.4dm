//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/10/21, 23:13:04
// ----------------------------------------------------
// Method: Fix_TableNames
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obRec; $obSel)
C_TEXT:C284($vtData)
$obSel:=ds:C1482.Letter.all()
For each ($obRec; $obSel)
	$vtData:=$obRec.body
	$vtData:=Replace string:C233($vtData; "Customers"; "Customer")
	$vtData:=Replace string:C233($vtData; "FirstName"; "NameFirst")
	$vtData:=Replace string:C233($vtData; "NameLast"; "LastName")
	$obRec.body:=$vtData
	$result_o:=$obRec.save()
End for each 
