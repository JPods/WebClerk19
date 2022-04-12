//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/28/18, 10:43:56
// ----------------------------------------------------
// Method: setTypeSalePopu
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($k; $i; $w)
//If (<>tcbManyType)
//TRACE
$myDate:=Current date:C33
QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]DateBegin:2<=$myDate; *)
QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]DateEnd:3>=$myDate)
$k:=Records in selection:C76([SpecialDiscount:44])
If ($k>0)
	ORDER BY:C49([SpecialDiscount:44]; [SpecialDiscount:44]TypeSale:1)
	FIRST RECORD:C50([SpecialDiscount:44])
	For ($i; 1; $k)
		$w:=Find in array:C230(<>aTypeSale; [SpecialDiscount:44]TypeSale:1)
		If ($w=-1)
			$w:=Size of array:C274(<>aTypeSale)+1
			INSERT IN ARRAY:C227(<>aTypeSale; $w)
			INSERT IN ARRAY:C227(<>aTypeSaleNum; $w)
			INSERT IN ARRAY:C227(<>aTypeSaleRecordNum; $w)
			<>aTypeSale{$w}:=[SpecialDiscount:44]TypeSale:1
			<>aTypeSaleNum{$w}:=[SpecialDiscount:44]PriceBase:8+1
			// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
			<>aTypeSaleRecordNum{$w}:=Record number:C243([SpecialDiscount:44])
		End if 
		NEXT RECORD:C51([SpecialDiscount:44])
	End for 
	UNLOAD RECORD:C212([SpecialDiscount:44])
End if 
//End if 
MESSAGES ON:C181