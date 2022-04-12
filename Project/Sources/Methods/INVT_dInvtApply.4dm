//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 14:38:18
// ----------------------------------------------------
// Method: INVT_dInvtApply
// Description
// File: INVT_dInvtApply.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130319_1429 we dont want to override the siteID for the entire Array
//### jwm ### 20130319_1439 use original dsiteID array only
//### bill ### 20130319_1439 use original dsiteID array only
// Modified by: William James (2013-11-16T00:00:00)  always on

REDUCE SELECTION:C351([DInventory:36]; 0)
C_LONGINT:C283($i; $k)

$k:=Size of array:C274(dItemNumKey)
If ($k>0)
	ARRAY LONGINT:C221($aDivision; $k)
	ARRAY TEXT:C222($asiteID; $k)
	C_TEXT:C284($div)
	Case of 
		: ((ptCurTable=(->[Order:3])) | (ptCurTable=(->[Invoice:26])))
			$div:=GL_GetDivsnCust([Customer:2]customerID:1)
		: (ptCurTable=(->[PO:39]))
			$div:=GL_GetDivsnPO([PO:39]poNum:5)
		Else 
			$div:=Storage:C1525.default.division
	End case 
	READ WRITE:C146([DInventory:36])
	C_LONGINT:C283($testUniqueID)
	For ($i; 1; $k)
		CREATE RECORD:C68([DInventory:36])
		$testUniqueID:=[DInventory:36]idNum:33
		[DInventory:36]itemNum:1:=dItemNumKey{$i}
		[DInventory:36]qtyOnHand:2:=dQtyOnHand{$i}
		[DInventory:36]qtyOnSO:3:=dQtyOnSO{$i}
		[DInventory:36]qtyOnPo:4:=dQtyOnPO{$i}
		[DInventory:36]qtyOnWO:5:=dQtyOnWO{$i}
		[DInventory:36]qtyOnAdj:6:=dQtyOnAdj{$i}
		[DInventory:36]unitCost:7:=dUnitCost{$i}
		[DInventory:36]projectNum:8:=dJobID{$i}
		[DInventory:36]docid:9:=dDocID{$i}
		[DInventory:36]idNumLine:10:=dLineNum{$i}
		[DInventory:36]receiptid:11:=dReceiptID{$i}
		[DInventory:36]customerID:12:=dSource{$i}
		[DInventory:36]reason:13:=dReason{$i}
		[DInventory:36]typeID:14:=dType{$i}
		[DInventory:36]dtCreated:15:=dDTCreated{$i}
		jDateTimeRecov([DInventory:36]dtCreated:15; ->[DInventory:36]dateCreated:39; ->[DInventory:36]timeCreated:40)
		[DInventory:36]note:18:=dNote{$i}
		[DInventory:36]takeAction:19:=dTakeAction{$i}
		[DInventory:36]siteID:20:=dSite{$i}
		[DInventory:36]unitPrice:21:=dUnitPrice{$i}
		[DInventory:36]changedBy:22:=dChangeBy{$i}
		
		[DInventory:36]division:29:=$div
		
		[DInventory:36]tableNum:30:=dTableNum{$i}
		SAVE RECORD:C53([DInventory:36])
	End for 
	//### jwm ### 20130319_1422 siteID set twice
	If ((ptCurTable=(->[Order:3])) & (<>bBomExpand))
		TRACE:C157
		IVNT_dRayInit
		Tally_InvtryByd("s"; -1112)
	End if 
	REDUCE SELECTION:C351([DInventory:36]; 0)
	READ ONLY:C145([DInventory:36])
	IVNT_dRayInit
End if 
