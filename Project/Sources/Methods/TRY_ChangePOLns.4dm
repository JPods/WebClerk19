//%attributes = {"publishedWeb":true}
//CONFIRM("Do you wish to save the adjustments.")
//If (OK=1)
//TRY_SaveAdjusts //save adjustment if the PO is changed
vi1:=aOpenPOs
QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=aOpenPOs{aOpenPOs})
$k:=Records in selection:C76([QQQPOLine:40])  //Build arrays for line items
ARRAY TEXT:C222(aBackOrder; $k)
ARRAY TEXT:C222(aPartNum; $k)
ARRAY REAL:C219(aQtyOnPOLns; $k)
ARRAY REAL:C219(aQtyRecds; $k)
ARRAY LONGINT:C221(aPOLnNo; $k)
ARRAY REAL:C219(aPOLnCosts; $k)
ORDER BY:C49([QQQPOLine:40]; [QQQPOLine:40]lineNum:14)
FIRST RECORD:C50([QQQPOLine:40])
aQtyRecds:=0
For ($i; 1; $k)  //fill line item arrays
	aBackOrder{$i}:=Num:C11([QQQPOLine:40]qtyBackLogged:5=0)*"*"
	aPartNum{$i}:=[QQQPOLine:40]itemNum:2
	aQtyOnPOLns{$i}:=[QQQPOLine:40]qtyOrdered:3
	aQtyRecds{$i}:=[QQQPOLine:40]qtyReceived:4
	aPOLnNo{$i}:=[QQQPOLine:40]lineNum:14
	aPOLnCosts{$i}:=[QQQPOLine:40]unitCost:7
	NEXT RECORD:C51([QQQPOLine:40])
End for 
vPOLineCnt:=Size of array:C274(aQtyRecds)
//End if 
//SELECTION TO ARRAY([POLine]QtyBackLogged;aReal1;[POLine]ItemNum;aPartNum
//;[POLine]QtyOrdered;aQtyOnPOLns;[POLine]QtyReceived;aQtyRecds;[POLines
//]LineNum;aPOLnNo;[POLine]UnitCost;aPOLnCosts)//