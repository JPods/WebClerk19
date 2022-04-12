//%attributes = {"publishedWeb":true}

//Method: PO_RecalcNotIn
QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=[PO:39]poNum:5)
PoLnFillRays(Records in selection:C76([QQQPOLine:40]))
vMod:=calcPO(True:C214)
Accept_CalcStat(->[PO:39]; True:C214; ->aPOQtyRcvd; ->aPOQtyBL)

SAVE RECORD:C53([PO:39])