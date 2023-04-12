//%attributes = {"publishedWeb":true}
//
////Procedure: EDI_OrdSaveRec
booAccept:=True:C214
C_BOOLEAN:C305(vbdTime; vbdMtls; vbdWos)
vbdTime:=False:C215
vbdMtls:=False:C215
vbdWos:=False:C215
allowAlerts_boo:=False:C215
acceptOrders
OrdLnRays(0)
allowAlerts_boo:=True:C214
ptCurTable:=->[Control:1]
vHere:=0
UNLOAD RECORD:C212([Order:3])