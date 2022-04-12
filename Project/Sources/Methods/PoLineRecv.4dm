//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-07T00:00:00, 13:12:38
// ----------------------------------------------------
// Method: PoLineRecv
// Description
// Modified: 10/07/16
// 
// 
//
// Parameters
// ----------------------------------------------------


READ ONLY:C145([Item:4])
READ ONLY:C145([QQQPOLine:40])
If (UserInPassWordGroup("Costing"))
	C_REAL:C285($origRecd)
	C_BOOLEAN:C305($noChange)
	If (bRecByChang=1)
		aPOQtyNow{aPOLineAction}:=pQtyShip
		
		poUniqueIDChange:=1
		
		If (aPoUniqueID{aPOLineAction}>1)
			QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]idUnique:32=aPoUniqueID{aPOLineAction})
			$origRecd:=[QQQPOLine:40]qtyReceived:4
		Else 
			$origRecd:=0
		End if 
		pQtyShip:=$origRecd+pQtyShip
	End if 
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aPoItemNum{aPOLineAction})
	If ((<>vbDoSrlNums) & ([Item:4]serialized:41))  //(aPOSerialRc{aPOLineAction}><>ciSRNotSerialized))
		If (aPOSerialRc{aPOLineAction}=<>ciSRNotSerialized)  //
			aPOSerialRc{aPOLineAction}:=CounterNew(->[DialingInfo:81])
		End if 
		pQtyShip:=Srl_RecvDialog(aPOLineAction; ->pPartNum; ->aPOSerialRc{aPOLineAction}; ->aPoSerialNm{aPOLineAction}; pQtyShip)  //search for serials 
		aPOQtyRcvd{aPOLineAction}:=pQtyShip
	End if 
	//why is this here
	//January 28, 1997
	//If (pQtyShip<0)
	//PO_LnRtnValueWa (pQtyShip;aPoUnitCost{aPOLineAction}
	//;aPoItemNum{aPOLineAction})
	//End if 
	aPoQtyBL{aPOLineAction}:=pQtyOrd-pQtyShip
	aPOQtyRcvd{aPOLineAction}:=pQtyShip
	aPOQtyNow{aPOLineAction}:=aPOQtyRcvd{aPOLineAction}-$origRecd
	If (bRecByChang=1)
		pQtyShip:=aPOQtyNow{aPOLineAction}
	End if 
	If (((aPOQtyOrder{aPOLineAction}>=0) & (aPOQtyRcvd{aPOLineAction}>=aPOQtyOrder{aPOLineAction})) | ((aPOQtyOrder{aPOLineAction}<0) & (aPOQtyRcvd{aPOLineAction}<=aPOQtyOrder{aPOLineAction})))
		aPOLnCmplt{aPOLineAction}:="x"
		pUse:=1
	Else 
		aPOLnCmplt{aPOLineAction}:=""
		pUse:=0
	End if 
	
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([QQQPOLine:40])
READ WRITE:C146([Item:4])
