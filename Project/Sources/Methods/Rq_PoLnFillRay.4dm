//%attributes = {"publishedWeb":true}

//Procedure: RqOrdLnFillRays  check this before changing
C_LONGINT:C283($lnTest; $i; $1; $w; $k)  //$1 number of lines
TRACE:C157
OrdLnRays(0)
$k:=Size of array:C274(<>aItemLnRec)
For ($i; 1; $k)
	$w:=Size of array:C274(aOLineNum)+1
	OrdLn_RaySize(1; $w; 1)
	GOTO RECORD:C242([QQQPOLine:40]; <>aItemLnRec{$i})
	aOPricePt{$w}:="PO"
	aOSerialRc{$w}:=[QQQPOLine:40]poNum:1
	aOLineNum{$w}:=[QQQPOLine:40]lineNum:14
	aOItemNum{$w}:=[QQQPOLine:40]itemNum:2
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[QQQPOLine:40]itemNum:2)
	aODescpt{$w}:=[QQQPOLine:40]description:6
	aOQtyOrder{$w}:=[QQQPOLine:40]qtyOrdered:3
	aODscntUP{$w}:=DiscountApply([QQQPOLine:40]unitCost:7; [QQQPOLine:40]discount:8; <>tcDecimalUC)
	aOExtPrice{$w}:=0
	aOExtCost{$w}:=[QQQPOLine:40]extendedCost:9
	
	aOUnitMeas{$w}:=[QQQPOLine:40]unitOfMeasure:12
	aOUnitWt{$w}:=[Item:4]weightAverage:8
	aOExtWt{$w}:=[Item:4]weightAverage:8*[QQQPOLine:40]qtyOrdered:3
	aOLocation{$w}:=<>aItemLnRec{$i}
	aOSeq{$w}:=[QQQPOLine:40]sequence:21
	aODateReq{$w}:=[QQQPOLine:40]dateExpected:15
	aoDateShipOn{$w}:=[QQQPOLine:40]dateExpected:15
	aoDateShipped{$w}:=[QQQPOLine:40]dateReceived:17
	aoProdBy{$w}:=[QQQPOLine:40]refCustomer:22
End for 
UNLOAD RECORD:C212([QQQPOLine:40])
UNLOAD RECORD:C212([Item:4])