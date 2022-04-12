//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/15/21, 23:21:15
// ----------------------------------------------------
// Method: DSProposalLineToOrderLine
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222($arrNames; 0)
ARRAY LONGINT:C221($arrTypes; 0)
C_TEXT:C284($vtFields)
C_OBJECT:C1216($clOrderLine; $clProposalLine; $obField)
$clOrderLine:=ds:C1482.OrderLine
For each ($obField; $clOrderLine)
	$vtFields:=$vtFields+","+$obField.name
End for each 
$vtFields:=Substring:C12($vtFields; 1; Length:C16($vtFields)-1)
$tableName:="OrderLine"
$tableName:="ProposalLine"
$tableName:="InvoiceLine"
OB GET PROPERTY NAMES:C1232(ds:C1482[$tableName]; $arrNames; $arrTypes)
C_LONGINT:C283($inc; $cnt)
SORT ARRAY:C229($arrNames; $arrTypes)
$cnt:=Size of array:C274($arrNames)
For ($inc; 1; $cnt)
	$vtFields:=$vtFields+"["+$tableName+"]"+$arrNames{$inc}+","
End for 
SET TEXT TO PASTEBOARD:C523($vtFields)

/// 