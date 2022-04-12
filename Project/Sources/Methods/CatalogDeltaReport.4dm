//%attributes = {}


C_OBJECT:C1216($voCatalog)






If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Bill James
	// Date and time: 10/12/20, 21:38:47
	// ----------------------------------------------------
	// Method: CatalogDeltaReport
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	C_LONGINT:C283($cntParameters)
	$cntParameters:=Count parameters:C259
	C_TEXT:C284($1; $vtAction)
	$vtAction:=$1
	C_TEXT:C284($2; $vtCatalog)
	$vtCatalog:=$2
	C_TEXT:C284($3; $vtItemNum)
	$vtItemNum:=$3
	C_TEXT:C284($4; $vtReason)
	$vtReason:=$4
	C_POINTER:C301($5; $ptReport)
	$ptReport:=$5
	C_POINTER:C301($5; $ptObjReport)
	$ptObjReport:=$5
	Case of 
		: ($vtAction="Start")
			CREATE EMPTY SET:C140([Item:4]; "CatalogUpdated")
			CREATE EMPTY SET:C140([Item:4]; "Added-Catalog")
			CREATE EMPTY SET:C140([Item:4]; "Skipped")
		: ($vtAction="End")
			SAVE SET:C184("Skipped"; Storage:C1525.folder.jitCatalog+$vtCatalog+"Skip"+DateTime_RFCString+".txt")
			SAVE SET:C184("Added-Catalog"; Storage:C1525.folder.jitCatalog+$vtCatalog+"Add"+DateTime_RFCString+".txt")
			SAVE SET:C184("CatalogUpdated"; Storage:C1525.folder.jitCatalog+$vtCatalog+"Update"+DateTime_RFCString+".txt")
		Else 
			Case of 
				: ($vtReason="Skip@")
					ADD TO SET:C119([Item:4]; "Skipped")
					$ptReport->:=$ptReport->+$vtItemNum+"\t"+$vtReason+"\r"
					// $ptObjReport->.skipped:=
				: ($vtReason="Add@")
					ADD TO SET:C119([Item:4]; "Added-Catalog")
					$ptReport->:=$ptReport->+$vtItemNum+"\t"+$vtReason+"\r"
				: ($vtReason="Update@")
					ADD TO SET:C119([Item:4]; "CatalogUpdated")
					$ptReport->:=$ptReport->+$vtItemNum+"\t"+$vtReason+"\r"
			End case 
	End case 
End if 