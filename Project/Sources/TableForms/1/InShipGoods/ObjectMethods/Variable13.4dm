C_LONGINT:C283($w; srPO)
If (vMod)
	TRACE:C157
	booAccept:=True:C214
	acceptPO
	vMod:=False:C215
End if 
$w:=Find in array:C230(aPOs; srPO)
If ($w=-1)
	QUERY:C277([PO:39]; [PO:39]idNum:5=srPO)
	If (Records in selection:C76([PO:39])=1)
		$w:=Size of array:C274(aPORecs)+1
		Ray_InsertElems($w; 1; ->aPOStatus; ->aPOs; ->aVendors; ->aPODate; ->aPOTotal; ->aPOOpenAmt; ->aPOShipTo; ->aPOAttn; ->aPORecs)
		Ray_VarLoadRay($w; ->aPOStatus; ->[PO:39]buyer:7; ->aPOs; ->[PO:39]idNum:5; ->aVendors; ->[PO:39]vendorCompany:39; ->aPODate; ->[PO:39]dateNeeded:3; ->aPOTotal; ->[PO:39]amount:19; ->aPOOpenAmt; ->[PO:39]amountBackLog:25; ->aPOShipTo; ->[PO:39]shipToCompany:8; ->aPOAttn; ->[PO:39]attention:26)
		aPORecs{$w}:=Record number:C243([PO:39])
		aPORecs:=$w
		viVert:=$w
		QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
		PoLnFillRays(Records in selection:C76([POLine:40]))
		//  --  CHOPPED  AL_UpdateArrays(ePoLines; Size of array(aPOLineAction))
	Else 
		BEEP:C151
	End if 
Else 
	aPORecs:=$w
	viVert:=$w
	GOTO RECORD:C242([PO:39]; aPORecs{aPORecs})
	QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
	PoLnFillRays(Records in selection:C76([POLine:40]))
	//  --  CHOPPED  AL_UpdateArrays(ePoLines; Size of array(aPOLineAction))
	PoLnFillVar(0)
End if 
If (ePos#0)
	//  --  CHOPPED  AL_UpdateArrays(ePOs; Size of array(aPORecs))
	// -- AL_SetScroll(ePOs; viVert; viHorz)
	// -- AL_SetLine(ePOs; $w)
End if 