//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 20:08:27
// ----------------------------------------------------
// Method: WebClerkShoppingCartAlready
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Modified by: Bill James (2015-12-21T00:00:00 qqqqqqq What is this for?)


C_LONGINT:C283($1; $tableNum)
$tableNum:=$1

C_LONGINT:C283(jitRecordNum)
C_LONGINT:C283(pvLineStyle)
jitRecordNum:=Record number:C243(Table:C252($tableNum)->)
//TRACE
C_TEXT:C284($tempItemNum)
C_LONGINT:C283($foundInCart)
$tempItemNum:=""
For ($i; 1; $k)
	$foundInCart:=0
	pvQtyAvailable:=0  //make sure this is cleared
	pvQtyLikely:=0
	pvQtyInCart:=0
	vReservations:=""
	vItemKeys:=""
	vLedgerLink:=""
	If (vLineStyleMod#0)
		pvLineStyle:=$i%vLineStyleMod
	End if 
	pvDuplicateStyle:=""
	C_LONGINT:C283($foundInCart)  //see single record test in WC_PageSendWithTags
	Case of 
		: ($tableNum=Table:C252(->[WebTempRec:101]))
			$foundInCart:=Find in array:C230(aShoppingCartItem; [WebTempRec:101]ItemNum:3)
		: ($tableNum=Table:C252(->[Item:4]))
			$foundInCart:=Find in array:C230(aShoppingCartItem; [Item:4]itemNum:1)
		: ($tableNum=Table:C252(->[OrderLine:49]))
			$foundInCart:=Find in array:C230(aShoppingCartItem; [OrderLine:49]itemNum:4)
		: ($tableNum=Table:C252(->[ProposalLine:43]))
			$foundInCart:=Find in array:C230(aShoppingCartItem; [ProposalLine:43]itemNum:2)
		Else 
			$foundInCart:=-1
			pvQtyInCart:=0
	End case 
	If ($foundInCart>0)
		pvQtyInCart:=aShoppingCartQty{$foundInCart}
		If (aShoppingCartTimes{$foundInCart}>1)
			pvDuplicateStyle:="Duplicate in cart"
		End if 
	End if 
	//
	Case of 
		: ($tableNum=4)
			$tempItemNum:=[Item:4]itemNum:1
		: ($tableNum=Table:C252(->[OrderLine:49]))
			$tempItemNum:=[OrderLine:49]itemNum:4
		: ($tableNum=Table:C252(->[OrderLine:49]))
			$tempItemNum:=[OrderLine:49]itemNum:4
	End case 
	If ($tempItemNum#"")
		$foundInCart:=Find in array:C230(aShoppingCartItem; $tempItemNum)
		If ($foundInCart>0)
			pvQtyInCart:=aShoppingCartQty{$foundInCart}
			//pvLineStyle:=101
		End if 
	End if 
End for 