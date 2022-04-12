//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/04/13, 11:53:20
// ----------------------------------------------------
// Method: acceptPO
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (booAccept=True:C214)
	If (newPo)
		[Vendor:38]dateLastPur:48:=[PO:39]dateOrdered:2
		[Vendor:38]amountLastPur:49:=[PO:39]amount:19
	End if 
	//  UNLOAD RECORD([Customer])
	If (Modified record:C314([Vendor:38]))
		SAVE RECORD:C53([Vendor:38])
	End if 
	If ((<>tcMONEYCHAR#strCurrency) & (<>tcMONEYCHAR#"") & (strCurrency#"") & ([PO:39]exchangeRate:45#0))
		vMod:=True:C214
		Exch_FillRays
	End if 
	If ((Modified record:C314([PO:39])) | (vMod))
		vMod:=calcPO(True:C214)
		Accept_CalcStat(->[PO:39]; True:C214; ->aPOQtyRcvd; ->aPOQtyBL)
		If ([PO:39]lineCount:42#Records in selection:C76([POLine:40]))  //safety check incase they changed selection of PoLines
			QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
		End if 
		[PO:39]lineCount:42:=Size of array:C274(aPOLineAction)
		SAVE RECORD:C53([PO:39])
		//
		POLn_RaySize(3; 0; 0)
		newPo:=False:C215
		<>aLastRecNum{39}:=Record number:C243([PO:39])
		ARRAY LONGINT:C221(aRayLines; 0)
		C_LONGINT:C283(ePoList)
		
		// inventory adjustments made in During of layout with File vs Subfile Record
		
		INVT_dInvtApply
		
	End if 
	vMod:=False:C215
	
	// Modified by: William James (2014-02-12T00:00:00 Subrecord eliminated)
	TransactionValidate
End if 