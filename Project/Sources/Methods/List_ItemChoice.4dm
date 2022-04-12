//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-15T00:00:00, 13:29:01
// ----------------------------------------------------
// Method: List_ItemChoice
// Description
// Modified: 04/15/17
// 
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k; $1; $2)
C_TEXT:C284($3; ItemChoice_TypeSaleSel)
ItemChoice_TypeSaleSel:=$3
$k:=$1

C_LONGINT:C283($thePrec)
$thePrec:=<>tcDecimalTt
ARRAY TEXT:C222($aItemStatus; 0)
C_REAL:C285($discntPrc; $discPercent; <>rQQAddQty)
C_LONGINT:C283($fia)
KeyModifierCurrent
If (<>vbQtyAvailable)
	If (OptKey=0)
		SELECTION TO ARRAY:C260([Item:4]status:117; $aItemStatus; [Item:4]retired:64; aTmpBoo3; [Item:4]backOrder:24; aTmpBoo1; [Item:4]serialized:41; aTmpBoo2; [Item:4]itemNum:1; aLsItemNum; [Item:4]description:7; aLsItemDesc; [Item:4]; aLsSrRec; [Item:4]qtyAvailable:73; aLsQtyOH; [Item:4]costAverage:13; aLsCost; Field:C253(4; $2)->; aLsPrice; [Item:4]qtyOnPo:20; aLsQtyPO; [Item:4]qtyOnSalesOrder:16; aLsQtySO; [Item:4]leadTimeSales:12; aLsLeadTime)
	Else 
		SELECTION TO ARRAY:C260([Item:4]status:117; $aItemStatus; [Item:4]retired:64; aTmpBoo3; [Item:4]backOrder:24; aTmpBoo1; [Item:4]serialized:41; aTmpBoo2; [Item:4]itemNum:1; aLsItemNum; [Item:4]description:7; aLsItemDesc; [Item:4]; aLsSrRec; [Item:4]qtyOnHand:14; aLsQtyOH; [Item:4]costAverage:13; aLsCost; Field:C253(4; $2)->; aLsPrice; [Item:4]qtyOnPo:20; aLsQtyPO; [Item:4]qtyOnSalesOrder:16; aLsQtySO; [Item:4]leadTimeSales:12; aLsLeadTime)
	End if 
Else 
	If (OptKey=1)
		SELECTION TO ARRAY:C260([Item:4]status:117; $aItemStatus; [Item:4]retired:64; aTmpBoo3; [Item:4]backOrder:24; aTmpBoo1; [Item:4]serialized:41; aTmpBoo2; [Item:4]itemNum:1; aLsItemNum; [Item:4]description:7; aLsItemDesc; [Item:4]; aLsSrRec; [Item:4]qtyAvailable:73; aLsQtyOH; [Item:4]costAverage:13; aLsCost; Field:C253(4; $2)->; aLsPrice; [Item:4]qtyOnPo:20; aLsQtyPO; [Item:4]qtyOnSalesOrder:16; aLsQtySO; [Item:4]leadTimeSales:12; aLsLeadTime)
	Else 
		SELECTION TO ARRAY:C260([Item:4]status:117; $aItemStatus; [Item:4]retired:64; aTmpBoo3; [Item:4]backOrder:24; aTmpBoo1; [Item:4]serialized:41; aTmpBoo2; [Item:4]itemNum:1; aLsItemNum; [Item:4]description:7; aLsItemDesc; [Item:4]; aLsSrRec; [Item:4]qtyOnHand:14; aLsQtyOH; [Item:4]costAverage:13; aLsCost; Field:C253(4; $2)->; aLsPrice; [Item:4]qtyOnPo:20; aLsQtyPO; [Item:4]qtyOnSalesOrder:16; aLsQtySO; [Item:4]leadTimeSales:12; aLsLeadTime)
	End if 
End if 

If (False:C215)
	//[Item]Status
	//$aItemStatus
	
	//[Item]QtyAllocated
	//aLsQtyAllocated
	//[Item]QtyAvailable
	//aLsQtyAvailable
	//[Item]QtyV_I
	//aLsQtyV_I
	
	//[Item]Retired
	//aLsRetired
	//[Item]BackOrder
	//aLsBackOrdered
	//[Item]Serialized
	//aLsSerialized
End if 


$scriptText:=""
QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="QQ"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="List_ItemChoice")
Case of 
	: (Records in selection:C76([TallyMaster:60])=1)
		$scriptText:=[TallyMaster:60]script:9
	: (Records in selection:C76([TallyMaster:60])>1)
		DB_ShowCurrentSelection(->[TallyMaster:60]; ""; 4; "Multiple Records")  //use current selection
End case 
REDUCE SELECTION:C351([TallyMaster:60]; 0)

ARRAY REAL:C219(aLSMargin; $k)  //New Qty On Hand  
ARRAY TEXT:C222(aLsDocType; $k)
ARRAY TEXT:C222(aLsText1; $k)
ARRAY TEXT:C222(aLsText2; $k)
ARRAY DATE:C224(aLsDate; $k)
ARRAY REAL:C219(aLsDiscount; $k)  //Discount
ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price
For ($i; 1; $k)
	aLsDocType{$i}:=""
	If (aTmpBoo3{$i})  //([Item]retired)
		aLsDocType{$i}:="R"
	End if 
	If (aTmpBoo1{$i})  //[Item]BackOrder
		aLsDocType{$i}:=aLsDocType{$i}+"b"
	End if 
	If (aTmpBoo2{$i})  //([Item]Serialized)
		aLsDocType{$i}:="s"+aLsDocType{$i}
	End if 
	
	aLsText1{$i}:=String:C10($i)
	If (aTmpBoo3{$i})  //([Item]Serialized)
		aLsText2{$i}:="Retired"
	End if 
	aLsText2{$i}:=$aItemStatus{$i}
	If (ItemChoice_TypeSaleSel#"")
		GOTO RECORD:C242([Item:4]; aLsSrRec{$i})
		
		pQtyOrd:=<>rQQAddQty  //variables required based on web pricing
		pvTypeSale:=ItemChoice_TypeSaleSel  //variables required based on web pricing
		ItemKeyPathVariables  //variables required based on web pricing
		
		//DscntSpecialClr (ItemChoice_TypeSaleSel)
		//DscntSetPrice (ItemChoice_TypeSaleSel)//sets vSpclDscn (global disc) or the array aDscnPC (item disc)
		
		//find and apply special discounts
		
		$discPercent:=pDiscnt
		//$fia:=Find in array(aDsctItem;[Item]ItemNum)
		//If ($fia>0)
		//$discPercent:=$discPercent+aDscnPC{$fia}
		//aLsPrice{$i}:=aBasePrice{$fia}
		//End if 
		
		// ### bj ### 20191004_1636 TESTTHIS
		aLsPrice{$i}:=pBasePrice  // ### jwm ### 20190723_1608
		
		
		$discntPrc:=DiscountApply(aLsPrice{$i}; $discPercent; 10)
		$discntPrc:=Round:C94($discntPrc; <>tcDecimalUP+4)
		//$priceDisc:=(aLsPrice{$i})-((aLsPrice{$i})*($discPercent/100))    
		aLsDiscount{$i}:=$discPercent
		aLsDiscountPrice{$i}:=Round:C94($discntPrc; $thePrec)
	End if 
	aLSMargin{$i}:=Margin4Price(aLsPrice{$i}; aLsCost{$i})
	If ($scriptText#"")
		ExecuteText(-1; $scriptText)
		// Else 
		// Modified by: Bill James (2015-02-03T00:00:00 Fixed. aTmpBoo1-3)
		// SORT ARRAY(aLsItemNum;aLsDocType;aLsItemDesc;aLsQtyOH;aLsQtySO;aLsQtyPO;aLsLeadTime;aLsPrice;aLsDiscount;aLsDiscountPrice;aLsCost;aLSMargin;aLsDate;aLsText1;aLsText2;aLsSrRec;aLsItemChild;aLsItemChildStr;aLsReason;aTmpBoo1;aTmpBoo2;aTmpBoo3)
	End if 
End for 
// Modified by: Bill James (2015-02-03T00:00:00 moved to outside the loop)
SORT ARRAY:C229(aLsItemNum; aLsDocType; aLsItemDesc; aLsQtyOH; aLsQtySO; aLsQtyPO; aLsLeadTime; aLsPrice; aLsDiscount; aLsDiscountPrice; aLsCost; aLSMargin; aLsDate; aLsText1; aLsText2; aLsSrRec; aLsItemChild; aLsItemChildStr; aLsReason)  //;aTmpBoo1;aTmpBoo2;aTmpBoo3)

ARRAY BOOLEAN:C223(aTmpBoo1; 0)
ARRAY BOOLEAN:C223(aTmpBoo2; 0)
ARRAY BOOLEAN:C223(aTmpBoo3; 0)
UNLOAD RECORD:C212([Item:4])
If ($k>1)
	UNLOAD RECORD:C212([ItemSpec:31])
End if 