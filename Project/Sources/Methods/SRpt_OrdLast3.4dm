//%attributes = {"publishedWeb":true}
//Procedure: SRpt_OrdLast3
//reports the last 3 significant purchases by a customer.
C_LONGINT:C283($i; $k; $subInc; $subCnt; $w)
If (ptCurTable=(->[Contact:13]))
	QUERY:C277([Order:3]; [Order:3]customerid:1=[Contact:13]customerID:1)
Else 
	QUERY:C277([Order:3]; [Order:3]customerid:1=[Customer:2]customerID:1)
End if 
ORDER BY:C49([Order:3]; [Order:3]dateOrdered:4; <)
$k:=Records in selection:C76([Order:3])
OrdLnRays(0)
If ($k>0)
	$i:=0
	$endLoop:=False:C215
	FIRST RECORD:C50([Order:3])
	Repeat 
		$i:=$i+1
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		FIRST RECORD:C50([Order:3])
		$subCnt:=Records in selection:C76([OrderLine:49])
		For ($subInc; 1; $subCnt)
			$w:=Find in array:C230(aOItemNum; [OrderLine:49]itemNum:4)
			If (($w=-1) & (Abs:C99([OrderLine:49]location:22)>99))
				$w:=Size of array:C274(aoLineAction)+1
				Ray_InsertElems($w; 1; ->aoLineAction; ->aOLineNum; ->aOItemNum; ->aOAltItem; ->aOQtyOrder; ->aOQtyShip; ->aOQtyBL; ->aODescpt; ->aOUnitPrice; ->aODiscnt; ->aODscntUP; ->aOPQDIR; ->aOExtPrice; ->aOUnitCost; ->aOExtCost; ->aOBackLog; ->aOTaxable; ->aOSaleTax; ->aOSaleComm; ->aOSalesRate; ->aORepComm; ->aORepRate; ->aOUnitMeas; ->aOUnitWt; ->aOExtWt; ->aOLocation; ->aOQtyOpen; ->aOSerialRc; ->aOSerialNm; ->aOSeq; ->aOPricePt; ->aODateReq)
				aOItemNum{$w}:=[OrderLine:49]itemNum:4
				aOAltItem{$w}:=[OrderLine:49]altItem:31
				aODescpt{$w}:=[OrderLine:49]description:5
				aOQtyOrder{$w}:=[OrderLine:49]qtyOrdered:6
				aOQtyShip{$w}:=[OrderLine:49]qtyShipped:7
				aOQtyBL{$w}:=[OrderLine:49]qtyBackLogged:8
				aOUnitPrice{$w}:=[OrderLine:49]unitPrice:9
				aODscntUP{$w}:=DiscountApply(aOUnitPrice{$w}; aODiscnt{$w}; <>tcDecimalUP)
				aOExtPrice{$w}:=[OrderLine:49]extendedPrice:11
				aOBackLog{$w}:=[OrderLine:49]backOrdAmount:26
				aOUnitMeas{$w}:=[OrderLine:49]unitofMeasure:19
				aODateReq{$w}:=[Order:3]dateOrdered:4
			End if 
			If ($w>=3)
				$subInc:=$subCnt
				$endLoop:=True:C214
				$i:=$k
			End if 
			NEXT RECORD:C51([OrderLine:49])
		End for 
		NEXT RECORD:C51([Order:3])
		REDUCE SELECTION:C351([OrderLine:49]; 0)
	Until ($i=$k)
End if 