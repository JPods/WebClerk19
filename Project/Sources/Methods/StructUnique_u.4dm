//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-23T00:00:00, 15:42:24
// ----------------------------------------------------
// Method: StructUnique_u
// Description
// Modified: 02/23/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($w; $1)
C_TEXT:C284($tableName)
C_POINTER:C301($ptArray)
If (Count parameters:C259=1)
	curTableNum:=$1
Else 
	If (curTableNum=0)
		curTableNum:=Table:C252(ptCurTable)
	End if 
End if 
$tableName:=Table name:C256(curTableNum)
$ptArray:=Get pointer:C304("<>a"+$tableName+"_FL")
$w:=Find in array:C230($ptArray->; "idNum")

// Change this to 


// CounterArrays

Case of 
	: ($w>0)
		theUniques{$w}:="u"
		//
	: (curTableNum=Table:C252(->[Customer:2]))
		theUniques{Field:C253(->[Customer:2]customerID:1)}:="u"
		//Struc_ReplacePr ("<>aProfile";"Profile";5)
		//
	: (curTableNum=Table:C252(->[Order:3]))
		theUniques{Field:C253(->[Order:3]orderNum:2)}:="u"
		//Struc_ReplacePr ("<>aOrdersProfile";"Profile";3)
		//
	: (curTableNum=Table:C252(->[Item:4]))
		theUniques{Field:C253(->[Item:4]itemNum:1)}:="u"
		$w:=Find in array:C230(theFields; "typeID")
		//theFields{$w}:="P0_"+<>aItemsType{1}
		//Struc_ReplacePr ("<>aItemsProfile";"Profile";4)
		//
	: (curTableNum=Table:C252(->[ItemSpec:31]))
		theUniques{Field:C253(->[ItemSpec:31]itemNum:1)}:="u"
		//Struc_ReplacePr ("<>aItemSpecProfile";"Profile";14)
		//
	: (curTableNum=Table:C252(->[Rep:8]))
		theUniques{Field:C253(->[Rep:8]repID:1)}:="u"
	: (curTableNum=Table:C252(->[TaxJurisdiction:14]))
		theUniques{Field:C253(->[TaxJurisdiction:14]taxJurisdiction:1)}:="u"
	: (curTableNum=Table:C252(->[Process:16]))
		theUniques{Field:C253(->[Process:16]process:2)}:="u"
	: (curTableNum=Table:C252(->[Employee:19]))
		theUniques{Field:C253(->[Employee:19]nameID:1)}:="u"
	: (curTableNum=Table:C252(->[Territory:25]))
		theUniques{Field:C253(->[Territory:25]salesNameID:1)}:="u"
	: (curTableNum=Table:C252(->[Invoice:26]))
		theUniques{Field:C253(->[Invoice:26]invoiceNum:2)}:="u"
		//Struc_ReplacePr ("<>aOrdersProfile";"Profile";3)
		//
	: (curTableNum=Table:C252(->[InventoryStack:29]))
		theUniques{Field:C253(->[InventoryStack:29]idNum:1)}:="u"
	: (curTableNum=Table:C252(->[UsageSummary:33]))
		theUniques{Field:C253(->[UsageSummary:33]periodDate:2)}:="u"
	: (curTableNum=Table:C252(->[Term:37]))
		theUniques{Field:C253(->[Term:37]termID:1)}:="u"
	: (curTableNum=Table:C252(->[Vendor:38]))
		theUniques{Field:C253(->[Vendor:38]vendorID:1)}:="u"
	: (curTableNum=Table:C252(->[PO:39]))
		theUniques{Field:C253(->[PO:39]poNum:5)}:="u"
	: (curTableNum=Table:C252(->[Proposal:42]))
		theUniques{Field:C253(->[Proposal:42]proposalNum:5)}:="u"
		//Struc_ReplacePr ("<>aOrdersProfile";"Profile";3)
	: (curTableNum=Table:C252(->[Usage:5]))
		theUniques{Field:C253(->[Usage:5]idNum:28)}:="u"
	: (curTableNum=Table:C252(->[SpecialDiscount:44]))
		theUniques{Field:C253(->[SpecialDiscount:44]idNum:4)}:="u"
	: (curTableNum=Table:C252(->[ItemSerial:47]))
		theUniques{Field:C253(->[ItemSerial:47]idNum:18)}:="u"
	: (curTableNum=Table:C252(->[Payment:28]))
		theUniques{Field:C253(->[Payment:28]idNum:8)}:="u"
	: (curTableNum=Table:C252(->[TechNote:58]))
		theUniques{Field:C253(->[TechNote:58]idNum:1)}:="u"
End case 