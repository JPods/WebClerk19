//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-17T00:00:00, 23:31:51
// ----------------------------------------------------
// Method: PricingLvlDflts
// Description
// Modified: 11/17/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k; $w)

ARRAY TEXT:C222(<>aTypeSale; 0)
ARRAY LONGINT:C221(<>aTypeSaleRecordNum; 0)
ARRAY LONGINT:C221(<>aTypeSaleNUM; 0)

SelectList_Init("TypeSale")

$k:=Size of array:C274(<>aTypeSale)
ARRAY LONGINT:C221(<>aTypeSaleRecordNum; $k)
ARRAY LONGINT:C221(<>aTypeSaleNUM; $k)

// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
For ($i; 1; $k)
	<>aTypeSaleRecordNum{$i}:=-2
	//(-1 is defaults, -2 Popups, -3 header, >=0 recordNum)
End for 


// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
$k:=Size of array:C274(<>aTypeSaleNum)  // ?????ZZZZ This should probably be changed
For ($i; $k; 1; -1)  // header is not defined
	If (<>aTypeSaleNum{$i}=0)
		Case of 
			: (<>aTypeSale{$i}+"@"=<>tcPriceLvlD)
				<>aTypeSaleNum{$i}:=5
			: (<>aTypeSale{$i}+"@"=<>tcPriceLvlC)
				<>aTypeSaleNum{$i}:=4
			: (<>aTypeSale{$i}+"@"=<>tcPriceLvlB)
				<>aTypeSaleNum{$i}:=3
				//  : (<>aTypeSale{$i}+"@")=<>tcPriceLvlA)
			Else 
				<>aTypeSaleNum{$i}:=2  // force them to be retail price unless match and exceed a defined price point
				// Modified by: Bill James (2015-01-19T00:00:00 changed them from being just first character and made 2 the default
				//Character code(
		End case 
	End if 
End for 

// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
PricingLvlAddType(<>tcPriceLvlA; 2; -1)
PricingLvlAddType(<>tcPriceLvlB; 3; -1)
PricingLvlAddType(<>tcPriceLvlC; 4; -1)
PricingLvlAddType(<>tcPriceLvlD; 5; -1)

$k:=Size of array:C274(<>aTypeSale)  // clear out any empty strings
For ($i; $k; 1; -1)
	If (<>aTypeSale{$i}="")
		DELETE FROM ARRAY:C228(<>aTypeSale; $i; 1)
		DELETE FROM ARRAY:C228(<>aTypeSaleNum; $i; 1)
		DELETE FROM ARRAY:C228(<>aTypeSaleRecordNum; $i; 1)
	End if 
End for 

//

// put on the header
INSERT IN ARRAY:C227(<>aTypeSale; 1)
INSERT IN ARRAY:C227(<>aTypeSaleNum; 1)
INSERT IN ARRAY:C227(<>aTypeSaleRecordNum; 1)
<>aTypeSale{1}:="Type Sale"
<>aTypeSaleNum{1}:=0
// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
<>aTypeSaleRecordNum{1}:=-3