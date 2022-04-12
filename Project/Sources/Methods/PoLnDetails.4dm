//%attributes = {"publishedWeb":true}
C_TEXT:C284(pPartNum)
C_REAL:C285(pQtyOrd; pQtyShip; pQtyBackOrd)
C_TEXT:C284(pDescript)
C_REAL:C285(pUnitPrice; pDiscnt; pExtPrice)
C_TEXT:C284(pUnitMeas)
C_LONGINT:C283(pSerialized)
C_TEXT:C284(pSerialNum)
C_TEXT:C284(pVendItem)
If (aPOLineAction>0)
	PO_VarRay(False:C215)
	jCenterWindow(516; 461; 1)
	DIALOG:C40([QQQPOLine:40]; "diaPoLineDetail")
	CLOSE WINDOW:C154
	Case of 
		: (myOK=1)
			PO_VarRay(True:C214)
		: (myOK=2)
			If ((pRefNum#0) & (booAccept) & (pRefNum#[Order:3]orderNum:2))
				If (Modified record:C314([PO:39]))
					acceptPO
				End if 
				QUERY:C277([Order:3]; [Order:3]orderNum:2=pRefNum)
				If (Records in selection:C76([Order:3])>0)
					MODIFY RECORD:C57([Order:3])
					NxPvPOs
				Else 
					BEEP:C151
					BEEP:C151
				End if 
			Else 
				BEEP:C151
				BEEP:C151
			End if 
		Else 
			PO_VarRay(False:C215)
	End case 
	vLineMod:=True:C214
	jNxPvButtonSet
Else 
	jAlertMessage(9209)
End if 