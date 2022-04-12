//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-18T00:00:00, 01:40:16
// ----------------------------------------------------
// Method: PricingLvlAddType
// Description
// Modified: 11/18/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $priceType)
C_LONGINT:C283($2; $number)
C_LONGINT:C283($3; $kind)
$priceType:=$1
$number:=$2
$kind:=$3
If ($priceType#"")
	$w:=Find in array:C230(<>aTypeSale; $priceType)  // <>tcPriceLvlD)  //6
	If ($w=-1)
		APPEND TO ARRAY:C911(<>aTypeSale; $priceType)
		APPEND TO ARRAY:C911(<>aTypeSaleNum; $number)
		APPEND TO ARRAY:C911(<>aTypeSaleRecordNum; $kind)
	Else 
		<>aTypeSaleNum{$w}:=$number
		// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
		<>aTypeSaleRecordNum{$w}:=$kind  //(-1 is defaults, -2 Popups, -3 header, >=0 recordNum)
	End if 
End if 