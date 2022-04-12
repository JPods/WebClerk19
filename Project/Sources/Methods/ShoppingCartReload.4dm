//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-17T00:00:00, 22:31:02
// ----------------------------------------------------
// Method: ShoppingCartReload
// Description
// Modified: 12/17/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// is this necessary???


//array TEXT(aShoppingCartItem;0)
//ARRAY REAL(aShoppingCartQty;0)
//ARRAY LONGINT(aShoppingCartTimes;0)
C_LONGINT:C283($tableNum)
ARRAY TEXT:C222($aItem; 0)
ARRAY REAL:C219($aQty; 0)
QUERY:C277([WebTempRec:101]; [WebTempRec:101]eventLogid:1=vleventID; *)
QUERY:C277([WebTempRec:101];  & [WebTempRec:101]qtyOrdered:4#0; *)
QUERY:C277([WebTempRec:101];  & [WebTempRec:101]posted:5=False:C215)
SELECTION TO ARRAY:C260([WebTempRec:101]itemNum:3; $aItem; [WebTempRec:101]qtyOrdered:4; $aQty)
UNLOAD RECORD:C212([WebTempRec:101])
C_LONGINT:C283($incCart; $cntCart; $fiaCart)
$cntCart:=Size of array:C274($aItem)
For ($incCart; $cntCart; 1; -1)
	$fiaCart:=Find in array:C230(aShoppingCartItem; $aItem{$incCart})
	If ($fiaCart<0)
		APPEND TO ARRAY:C911(aShoppingCartItem; $aItem{$incCart})
		APPEND TO ARRAY:C911(aShoppingCartQty; $aQty{$incCart})
		APPEND TO ARRAY:C911(aShoppingCartTimes; 1)
		aShoppingCartQty{Size of array:C274(aShoppingCartItem)}:=$aQty{$incCart}
	Else 
		aShoppingCartQty{$fiaCart}:=aShoppingCartQty{$fiaCart}+$aQty{$incCart}
		aShoppingCartTimes{$fiaCart}:=aShoppingCartTimes{$fiaCart}+1
	End if 
End for 
//see multi record test in WC_PageSendWithTags
C_LONGINT:C283($foundInCart)  //see single record test in WC_PageSendWithTags
Case of 
	: ($tableNum=Table:C252(->[WebTempRec:101]))
		$foundInCart:=Find in array:C230(aShoppingCartItem; [WebTempRec:101]itemNum:3)
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