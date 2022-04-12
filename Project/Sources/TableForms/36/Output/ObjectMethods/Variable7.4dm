FIRST RECORD:C50([DInventory:36])
C_BOOLEAN:C305($doBOM)
C_TEXT:C284($doFileLtr)
$doBOM:=False:C215
Case of 
	: ([DInventory:36]typeID:14="")  // Modified by: williamjames (111216 checked for <= length protection)
		$doFileLtr:="p"
	: ([DInventory:36]typeID:14[[1]]="i")
		$ptField:=(->[DInventory:36]qtyOnHand:2)
		CONFIRM:C162("Adjust Inventory base on changes in INVOICES."+"\r"+"\r"+"Changes CANNOT be undone?")
		$doBOM:=(OK=1)
		$doFileLtr:="i"
	: ([DInventory:36]typeID:14[[1]]="s")
		$ptField:=(->[DInventory:36]qtyOnSO:3)
		CONFIRM:C162("Adjust BOM by On Order Qty."+"\r"+"\r"+"Changes CANNOT be undone?")
		$doBOM:=(OK=1)
		$doFileLtr:="s"
	Else 
		$doFileLtr:="p"
End case 
If ($doBOM)
	CONFIRM:C162("Are you sure, changes CANNOT be undone?")
	If (OK=1)
		C_BOOLEAN:C305($bAccountForQtyOnHand)
		CONFIRM:C162("Do you want to account for Quantity on Hand?")
		$bAccountForQtyOnHand:=(OK=1)
		Tally_InvtryByd($doFileLtr; -1112; $bAccountForQtyOnHand)
		SET WINDOW TITLE:C213(Table name:C256(ptCurTable)+":  "+String:C10(Records in selection:C76(ptCurTable->)))
	End if 
End if 