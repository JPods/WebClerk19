//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/28/08, 15:47:53
// ----------------------------------------------------
// Method: IEA_SuperiorField
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $2; $3; $4; $5)
//C_TEXT($0)
$3->:=-1
Case of 
	: ($1=(->[Invoice:26]))
		Case of 
			: ($2=(->[Customer:2]))
				$3->:=Field:C253(->[Invoice:26]customerID:3)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
				
			: ($2=(->[Order:3]))
				$3->:=Field:C253(->[Invoice:26]orderNum:1)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
	: ($1=(->[Order:3]))
		Case of 
			: ($2=(->[Customer:2]))
				$3->:=Field:C253(->[Order:3]customerID:1)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
	: ($1=(->[Proposal:42]))
		Case of 
			: ($2=(->[Customer:2]))
				$3->:=Field:C253(->[Proposal:42]customerID:1)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
	: ($1=(->[Service:6]))
		Case of 
			: ($2=(->[Customer:2]))
				$3->:=Field:C253(->[Service:6]customerID:1)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
			: ($2=(->[Contact:13]))
				$3->:=Field:C253(->[Service:6]contactid:52)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
	: ($1=(->[CallReport:34]))
		Case of 
			: ($2=(->[Customer:2]))
				$3->:=Field:C253(->[CallReport:34]customerID:1)
				$4->:=Field:C253(->[CallReport:34]tableNum:2)
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
			: ($2=(->[Contact:13]))
				$3->:=Field:C253(->[CallReport:34]contactid:44)
				$4->:=Field:C253(->[CallReport:34]tableNum:2)
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
		
	: ($1=(->[Document:100]))
		Case of 
			: ($2=(->[Customer:2]))
				$3->:=Field:C253(->[Document:100]customerID:7)
				$4->:=Field:C253(->[Document:100]tableNum:6)
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
			: ($2=(->[Contact:13]))
				$3->:=Field:C253(->[Document:100]customerID:7)
				$4->:=Field:C253(->[Document:100]tableNum:6)
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
			: ($2=(->[Vendor:38]))
				$3->:=Field:C253(->[Document:100]customerID:7)
				$4->:=Field:C253(->[Document:100]tableNum:6)
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
		
	: ($1=(->[PO:39]))
		Case of 
			: ($2=(->[Vendor:38]))
				$3->:=Field:C253(->[PO:39]vendorID:1)
				$4->:=-1
				$5->:=STR_GetUniqueFieldNum(Table name:C256($2))
		End case 
		
	: ($1=(->[BOM:21]))
		$3->:=Field:C253(->[BOM:21]itemNum:1)
		$4->:=-1
		$4->:=Table:C252($2)
		$5->:=Field:C253(->[Item:4]itemNum:1)
		
		
End case 


