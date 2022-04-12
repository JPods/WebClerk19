//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $3; $4; $5; $k)
//$1 -- 1 insert elements; -1 delete elements
//         0 clear array
$4:=-$4
Case of 
	: ($1=0)
		$k:=0
		ARRAY TEXT:C222(aLItmAlpha; $k)
		ARRAY TEXT:C222(aLItmDesc; $k)
		ARRAY LONGINT:C221(aLItmQtyLow; $k)
		ARRAY REAL:C219(aLItmOnHand; $k)  //Current Qty On Hand
		ARRAY LONGINT:C221(aLitmFrcst; $k)  //forecast by next usage period
		ARRAY REAL:C219(aLItmOnPO; $k)  //Currently On PO
		ARRAY REAL:C219(aLItmOnSO; $k)  //Currently On SO
		ARRAY REAL:C219(aLItmQtyMin; $k)  //Currently On PO
		ARRAY REAL:C219(aLItmCosts; $k)
		ARRAY LONGINT:C221(aLItmLeadTm; $k)  //Current Qty On Sales Ord
		ARRAY LONGINT:C221(aLItmRecNum; $k)
		ARRAY TEXT:C222(aLItmVend; $k)
	: ($1=1)
		$k:=Size of array:C274(aLItmAlpha)+1
		INSERT IN ARRAY:C227(aLItmAlpha; $k; 1)
		INSERT IN ARRAY:C227(aLItmDesc; $k; 1)
		INSERT IN ARRAY:C227(aLItmQtyLow; $k; 1)
		INSERT IN ARRAY:C227(aLItmOnHand; $k; 1)
		INSERT IN ARRAY:C227(aLitmFrcst; $k; 1)
		INSERT IN ARRAY:C227(aLItmOnPO; $k; 1)
		INSERT IN ARRAY:C227(aLItmOnSO; $k; 1)
		INSERT IN ARRAY:C227(aLItmQtyMin; $k; 1)
		INSERT IN ARRAY:C227(aLItmCosts; $k; 1)
		INSERT IN ARRAY:C227(aLItmLeadTm; $k; 1)
		INSERT IN ARRAY:C227(aLItmRecNum; $k; 1)
		INSERT IN ARRAY:C227(aLItmVend; $k; 1)
		aLItmAlpha{$k}:=[Item:4]itemNum:1
		aLItmDesc{$k}:=[Item:4]description:7
		aLItmQtyLow{$k}:=$4
		aLItmOnHand{$k}:=[Item:4]qtyOnHand:14
		aLitmFrcst{$k}:=$5
		aLItmOnPO{$k}:=[Item:4]qtyOnPo:20
		aLItmOnSO{$k}:=[Item:4]qtyOnSalesOrder:16
		aLItmQtyMin{$k}:=[Item:4]qtyMinStock:18
		aLItmCosts{$k}:=[Item:4]costLastInShip:47
		aLItmLeadTm{$k}:=[Item:4]leadTimeSales:12
		aLItmRecNum{$k}:=Record number:C243([Item:4])
		aLItmVend{$k}:=[Item:4]vendorId:45
	: ($1=-1)
		DELETE FROM ARRAY:C228(aLItmAlpha; $2; $3)
		DELETE FROM ARRAY:C228(aLItmDesc; $2; $3)
		DELETE FROM ARRAY:C228(aLItmQtyLow; $2; $3)
		DELETE FROM ARRAY:C228(aLItmOnHand; $2; $3)
		DELETE FROM ARRAY:C228(aLitmFrcst; $2; $3)
		DELETE FROM ARRAY:C228(aLItmOnPO; $2; $3)
		DELETE FROM ARRAY:C228(aLItmOnSO; $2; $3)
		DELETE FROM ARRAY:C228(aLItmQtyMin; $2; $3)
		DELETE FROM ARRAY:C228(aLItmCosts; $2; $3)
		DELETE FROM ARRAY:C228(aLItmLeadTm; $2; $3)
		DELETE FROM ARRAY:C228(aLItmRecNum; $2; $3)
		DELETE FROM ARRAY:C228(aLItmVend; $2; $3)
End case 