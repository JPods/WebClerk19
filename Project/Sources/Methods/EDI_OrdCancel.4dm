//%attributes = {"publishedWeb":true}
//Procedure: EDI_OrdCancel
booAccept:=True:C214
allowAlerts_boo:=False:C215
OrdLnRays(0)
allowAlerts_boo:=True:C214
newOrd:=True:C214
CounterRecover(ptCurTable)
ptCurTable:=->[Control:1]
vHere:=0
UNLOAD RECORD:C212([Order:3])


