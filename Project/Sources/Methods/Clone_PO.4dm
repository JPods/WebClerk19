//%attributes = {"publishedWeb":true}
//Procedure: Clone_PO
C_LONGINT:C283($i; $k)
DUPLICATE RECORD:C225([PO:39])
REDUCE SELECTION:C351([POLine:40]; 0)
CLEAR SET:C117("POLineCur")
CREATE EMPTY SET:C140([POLine:40]; "POLineCur")
//  SEARCH([POLine];[POLine]POLineKey=[PO]PONum)
// ### bj ### 20190304_2330
// needed to retain the line items with new iLoProcedure and Relate procedures
C_BOOLEAN:C305(vbIsClone)
vbIsClone:=True:C214
[PO:39]idNum:5:=CounterNew(->[PO:39])
TaskIDAssign(->[PO:39]idNumTask:69)
srPO:=[PO:39]idNum:5
newPo:=True:C214
[PO:39]customerPo:34:=""
[PO:39]dateOrdered:2:=Current date:C33
[PO:39]buyer:7:=Current user:C182
[PO:39]vendorInvoice:29:=""
[PO:39]shipDate:36:=!00-00-00!
[PO:39]dateComplete:4:=!00-00-00!
[PO:39]complete:65:=0
[PO:39]dateNeeded:3:=Current date:C33
[PO:39]idNumProject:6:=0
[PO:39]idNumOrder:18:=0
[PO:39]vendorDocid:56:=""
[PO:39]dateVendorInvoice:58:=!00-00-00!
[PO:39]dateRequested:59:=!00-00-00!
For ($i; 1; Size of array:C274(aPOLineAction))
	aPOLineAction{$i}:=-3
	aPOQtyRcvd{$i}:=0
	aPODateExp{$i}:=!00-00-00!
	aPOOrdRef{$i}:=0
	aPODateRcvd{$i}:=!00-00-00!
	aPOLnCmplt{$i}:=""
	
	aPoUniqueID{$i}:=-3
	aPOLineAction{$i}:=-3
	
	If (aPOSerialRc{$i}#<>ciSRNotSerialized)
		aPOSerialRc{$i}:=<>ciSRUnknown
	End if 
	PoLnExtend($i)
End for 
REDUCE SELECTION:C351([POLine:40]; 0)
vLineMod:=True:C214
FontSrchLabels(1)
//  --  CHOPPED  AL_UpdateArrays(ePoList; Size of array(aPOLineAction))