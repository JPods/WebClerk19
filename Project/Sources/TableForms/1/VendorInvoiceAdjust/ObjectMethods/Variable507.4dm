TRACE:C157
C_LONGINT:C283(vlReceiptID; vlLastReceiptID)
C_BOOLEAN:C305(haveReceiptID; vbSpreadFreight)
If (vMod)
	If (vsVendorPacking="")
		ALERT:C41("Enter Vendor PackList")
	Else 
		If (vlReceiptID<10)
			haveReceiptID:=True:C214
			booAccept:=True:C214
			vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1; True:C214)
			vbSpreadFreight:=False:C215
		End if 
		
		acceptPO
		//haveReceiptID:=False
		vMod:=False:C215
		vLineMod:=False:C215
		//Else 
		//ALERT("Totals must match or freight only must equal total.")
		
		
		$w:=Find in array:C230(aPoRcptID; [POReceipt:95]idNum:1)
		If ($w<1)
			PoReceiptFillRay(-3; 1; 1)
			PoReceiptFillRay(-7; 1)
		Else 
			vlLastReceiptID:=vlReceiptID
		End if 
		QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=vlReceiptID)
		Try_AdjRayFill(Records in selection:C76([InventoryStack:29]))
		ARRAY LONGINT:C221(aStkSelect; 0)
		$k:=Size of array:C274(aStkReceiptID)
		viVert:=0
		For ($i; 1; $k)
			If (aStkReceiptID{$i}=[POReceipt:95]idNum:1)
				INSERT IN ARRAY:C227(aStkSelect; 1; 1)
				aStkSelect{1}:=$i
				viVert:=MaxValueReturn($i; $i; viVert)
			End if 
		End for 
		//  --  CHOPPED  AL_UpdateArrays(eShipAdj; -2)
		// -- AL_SetSelect(eShipAdj; aStkSelect)
		// -- AL_SetScroll(eShipAdj; viVert; viHorz)
	End if 
End if 
vlReceiptID:=0
