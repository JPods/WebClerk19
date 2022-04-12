//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-17T00:00:00, 12:26:06
// ----------------------------------------------------
// Method: ShoppingCartToArrays
// Description
// Modified: 01/17/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// send to web pages so javascripts can can update itemLists

// Used in TagsToDataBloc

//array TEXT(aShoppingCartItem;0)
//ARRAY REAL(aShoppingCartQty;0)
//ARRAY LONGINT(aShoppingCartTimes;0)
C_LONGINT:C283($tableNum)
ARRAY TEXT:C222($aItem; 0)
ARRAY REAL:C219($aQty; 0)
// Should only be loaded if we already have the WebTempRecs in selection
// QUERY([WebTempRec];[WebTempRec]eventID=vleventID;*)
// QUERY([WebTempRec]; & [WebTempRec]QtyOrdered#0;*)
// QUERY([WebTempRec]; & [WebTempRec]Posted=False)
SELECTION TO ARRAY:C260([WebTempRec:101]itemNum:3; $aItem; [WebTempRec:101]qtyOrdered:4; $aQty)
// UNLOAD RECORD([WebTempRec])
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

If (False:C215)  // check for value in TagsToDataBlock, should this be extended to more than WebTempRecs? 
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
End if 

