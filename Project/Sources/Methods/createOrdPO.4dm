//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 15:00:14
// ----------------------------------------------------
// Method: createOrdPO
// Description
// TestThis
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($popPO; $popVend)
C_POINTER:C301($curFilePt)
$popPO:=False:C215
$popVend:=False:C215
$curFilePt:=ptCurTable
ptCurTable:=(->[Customer:2])
If (vHere>1)
	If (Record number:C243([Vendor:38])>-1)
		PUSH RECORD:C176([Vendor:38])
		$popVend:=True:C214
	End if 
	If (Record number:C243([PO:39])>-1)
		PUSH RECORD:C176([PO:39])
	End if 
	$popPO:=True:C214
End if 
jSrchCustLoad(->[Customer:2]; ->[Customer:2]company:2; ->srCustomer; False:C215)
If ((myOK>0) & (Records in selection:C76([Customer:2])=1))
	OrderCreateBasics
	$k:=Size of array:C274(aRayLines)
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aPoItemNum{aRayLines{$i}})
		pPartNum:=aPoItemNum{aRayLines{$i}}
		pDescript:=aPODescpt{aRayLines{$i}}
		viOrdLnCnt:=viOrdLnCnt+1
		OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
		aOQtyOrder{viOrdLnCnt}:=aPOQtyOrder{aRayLines{$i}}
		aOUnitCost{viOrdLnCnt}:=aPoDscntUP{aRayLines{$i}}
		OrdLnExtend(viOrdLnCnt)
	End for 
	acceptOrders
	DB_ShowCurrentSelection(->[Order:3]; ""; 1; "")  //tablePt, script, flowBranch, Title
	//
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([Customer:2])
	
Else 
	BEEP:C151
End if 
ptCurTable:=$curFilePt