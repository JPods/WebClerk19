//%attributes = {"publishedWeb":true}
//Procedure: List_RaySize
C_LONGINT:C283($1; $2; $countAdd; $thisElement)
$thisElement:=0
$countAdd:=1
If (Count parameters:C259>0)
	$thisElement:=$1
	If (Count parameters:C259>1)
		$countAdd:=$2
	End if 
End if 
Case of 
	: (Count parameters:C259=1)
		ARRAY TEXT:C222(aLsDocType; $thisElement)
		ARRAY TEXT:C222(aLsItemNum; $thisElement)
		ARRAY TEXT:C222(aLsItemDesc; $thisElement)
		
		ARRAY REAL:C219(aLsQtyOH; $thisElement)  //Qty On Hand
		ARRAY REAL:C219(aLsQtySO; $thisElement)  //Qty On SO
		ARRAY REAL:C219(aLsQtyPO; $thisElement)  //New Qty On PO
		
		ARRAY LONGINT:C221(aLsLeadTime; $thisElement)  //Lead time
		ARRAY REAL:C219(aLsPrice; $thisElement)  //Price
		ARRAY REAL:C219(aLsDiscount; $thisElement)  //Discount
		ARRAY REAL:C219(aLsDiscountPrice; $thisElement)  //Discounted Price
		ARRAY REAL:C219(aLsCost; $thisElement)  //cost
		ARRAY REAL:C219(aLSMargin; $thisElement)  //margin
		ARRAY DATE:C224(aLsDate; $thisElement)  //date
		ARRAY TEXT:C222(aLsText1; $thisElement)  //as Needed
		ARRAY TEXT:C222(aLsText2; $thisElement)  //as Needed
		ARRAY LONGINT:C221(aLsSrRec; $thisElement)  //Item record number
		ARRAY BOOLEAN:C223(aLsItemChild; $thisElement)  //Item has child
		ARRAY TEXT:C222(aLsItemChildStr; $thisElement)  //Item has child string
		ARRAY TEXT:C222(aLsReason; $thisElement)  //Reason
		
		//ARRAY REAL(aLsQtyAvailable;$thisElement)//Qty Available
		//ARRAY BOOLEAN(aLsRetired;$thisElement)// Retired
		//ARRAY LONGINT(aLsDisplay;$thisElement)//New Qty On PO
		//array TEXT(aLsStatus;$thisElement)//New Qty On PO
		
	: ($thisElement>0)
		INSERT IN ARRAY:C227(aLsDocType; $thisElement; $countAdd)
		INSERT IN ARRAY:C227(aLsItemNum; $thisElement; $countAdd)
		INSERT IN ARRAY:C227(aLsItemDesc; $thisElement; $countAdd)
		//INSERT ELEMENT(aLsQtyAvailable;$thisElement;$countAdd)//Qty Available
		INSERT IN ARRAY:C227(aLsQtyOH; $thisElement; $countAdd)  //Qty On Hand
		INSERT IN ARRAY:C227(aLsQtySO; $thisElement; $countAdd)  //Qty On SO
		INSERT IN ARRAY:C227(aLsQtyPO; $thisElement; $countAdd)  //New Qty On PO
		INSERT IN ARRAY:C227(aLsLeadTime; $thisElement; $countAdd)  //Lead time
		INSERT IN ARRAY:C227(aLsPrice; $thisElement; $countAdd)  //Price
		INSERT IN ARRAY:C227(aLsDiscount; $thisElement; $countAdd)  //Discount
		INSERT IN ARRAY:C227(aLsDiscountPrice; $thisElement; $countAdd)  //Discounted Price
		INSERT IN ARRAY:C227(aLsCost; $thisElement; $countAdd)  //cost
		INSERT IN ARRAY:C227(aLSMargin; $thisElement; $countAdd)  //margin
		INSERT IN ARRAY:C227(aLsDate; $thisElement; $countAdd)  //date
		INSERT IN ARRAY:C227(aLsText1; $thisElement; $countAdd)  //as Needed
		INSERT IN ARRAY:C227(aLsText2; $thisElement; $countAdd)  //as Needed
		INSERT IN ARRAY:C227(aLsSrRec; $thisElement; $countAdd)  //Item record number
		INSERT IN ARRAY:C227(aLsItemChild; $thisElement; $countAdd)  //Item has child
		INSERT IN ARRAY:C227(aLsItemChildStr; $thisElement; $countAdd)  //Item has child string
		INSERT IN ARRAY:C227(aLsReason; $thisElement; $countAdd)  //Reason
		
		//INSERT ELEMENT(aLsQtyAvailable;$thisElement;$countAdd)//Qty Available
		//INSERT ELEMENT(aLsRetired;$thisElement;$countAdd)// Retired
		//INSERT ELEMENT(aLsDisplay;$thisElement;$countAdd)//Display color
		//INSERT ELEMENT(aLsStatus;$thisElement;$countAdd)//Status
		
	: ($1=-1)
		DELETE FROM ARRAY:C228(aLsDocType; $thisElement; $countAdd)
		DELETE FROM ARRAY:C228(aLsItemNum; $thisElement; $countAdd)
		DELETE FROM ARRAY:C228(aLsItemDesc; $thisElement; $countAdd)
		//DELETE ELEMENT(aLsQtyAvailable;$thisElement;$countAdd)//Qty Available
		DELETE FROM ARRAY:C228(aLsQtyOH; $thisElement; $countAdd)  //Qty On Hand
		DELETE FROM ARRAY:C228(aLsQtySO; $thisElement; $countAdd)  //Qty On SO
		DELETE FROM ARRAY:C228(aLsQtyPO; $thisElement; $countAdd)  //New Qty On PO
		DELETE FROM ARRAY:C228(aLsLeadTime; $thisElement; $countAdd)  //Lead time
		DELETE FROM ARRAY:C228(aLsPrice; $thisElement; $countAdd)  //Price
		DELETE FROM ARRAY:C228(aLsDiscount; $thisElement; $countAdd)  //Discount
		DELETE FROM ARRAY:C228(aLsDiscountPrice; $thisElement; $countAdd)  //Discounted Price
		DELETE FROM ARRAY:C228(aLsCost; $thisElement; $countAdd)  //cost
		DELETE FROM ARRAY:C228(aLSMargin; $thisElement; $countAdd)  //margin
		DELETE FROM ARRAY:C228(aLsDate; $thisElement; $countAdd)  //date
		DELETE FROM ARRAY:C228(aLsText1; $thisElement; $countAdd)  //as Needed
		DELETE FROM ARRAY:C228(aLsText2; $thisElement; $countAdd)  //as Needed
		DELETE FROM ARRAY:C228(aLsSrRec; $thisElement; $countAdd)  //Item record number
		DELETE FROM ARRAY:C228(aLsItemChild; $thisElement; $countAdd)  //Item has child
		DELETE FROM ARRAY:C228(aLsItemChildStr; $thisElement; $countAdd)  //Item has child string
		DELETE FROM ARRAY:C228(aLsReason; $thisElement; $countAdd)  //Reason
		
		//DELETE ELEMENT(aLsQtyAvailable;$thisElement;$countAdd)//Qty Available
		//DELETE ELEMENT(aLsRetired;$thisElement;$countAdd)// Retired
		//DELETE ELEMENT(aLsDisplay;$thisElement;$countAdd)//Display color
		//DELETE ELEMENT(aLsStatus;$thisElement;$countAdd)//Status
End case 
//aLsDocType//aBackOrder
//aLsItemNum;aPartNum
//aLsItemDesc;aPartDesc
//aLsQtyOH;aQtyOnHand//Current Qty On Hand
//aLsQtySO;aQtyOrd//Qty On SO   //Qty for the Adjustment
//aLsQtyPO;aQtyOnPOLns//New Qty On PO
//aLsLeadTime;aLeadTime//Lead time
//aLsPrice;???????//Price
//aLsCost;aCosts//cost
//aLSMargin;??????//margin
//aLsDate//date
//aLsText1;aItmText1//as Needed
//aLsText2;aItmText2//as Needed
//aLsSrRec;aItemSrRec//Item record number

//???????;aPartQty//New Qty On Hand
//???????;aQtyRecds