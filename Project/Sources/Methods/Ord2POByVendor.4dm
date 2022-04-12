//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/26/19, 02:51:27
// ----------------------------------------------------
// Method: Ord2POByVendor
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Order2POForceVendor


If (allowAlerts_boo)
	KeyModifierCurrent
	CONFIRM:C162("Process Order Lines to Primary Vendor PO.")
Else 
	OK:=1
End if 
If (OK=1)
	REDUCE SELECTION:C351([PO:39]; 0)
	If (Size of array:C274(aOrdLnSel)=0)
		jAlertMessage(9209)
	Else 
		If ((OptKey=1) & (vHere>=2) & (ptCurTable=(->[Order:3])))
			$k:=Size of array:C274(aOrdLnSel)
		Else 
			If (vHere<2)
				//QUERY([Customer];[Customer]customerID=[Order]customerID)
				NxPvOrders
			End if 
			$k:=Size of array:C274(aoLineAction)
			ArraySelectAllAreaList(->aOrdLnSel; ->aoLineAction)
		End if 
	End if 
	ARRAY TEXT:C222($aItemNum; $k)
	ARRAY TEXT:C222($aItemVendID; $k)
	ARRAY REAL:C219($aQtyOrdered; $k)
	ARRAY LONGINT:C221($aSelect; $k)
	//
	C_TEXT:C284($curVend)
	$curVend:="as3~//z94./"
	ARRAY TEXT:C222($aListOfVendors; 0)
	ARRAY LONGINT:C221($aNumOfLines; 0)
	//
	TRACE:C157
	For ($i; 1; $k)
		$aItemNum{$i}:=aOItemNum{aOrdLnSel{$i}}
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$aItemNum{$i})
		$aItemVendID{$i}:=[Item:4]vendorID:45
		$w:=Find in array:C230($aListOfVendors; $aItemVendID{$i})
		If ($w<1)
			$curVend:=$aItemVendID{$i}
			INSERT IN ARRAY:C227($aListOfVendors; 1; 1)
			INSERT IN ARRAY:C227($aNumOfLines; 1; 1)
			$aListOfVendors{1}:=$aItemVendID{$i}
			$w:=1
		End if 
		$aNumOfLines{$w}:=$aNumOfLines{$w}+1  //to set the size of the selected lines by vendor
		$aQtyOrdered{$i}:=aOQtyOrder{aOrdLnSel{$i}}
		$aSelect{$i}:=aOrdLnSel{$i}
	End for 
	UNLOAD RECORD:C212([Item:4])
	SORT ARRAY:C229($aItemVendID; $aItemNum; $aQtyOrdered; $aSelect)
	//
	CREATE EMPTY SET:C140([PO:39]; "Current")
	$kPO:=Size of array:C274($aListOfVendors)
	For ($incPO; 1; $kPO)
		ARRAY LONGINT:C221(aOrdLnSel; 0)
		For ($i; 1; $k)
			If ($aItemVendID{$i}=$aListOfVendors{$incPO})
				INSERT IN ARRAY:C227(aOrdLnSel; 1; 1)
				aOrdLnSel{1}:=$aSelect{$i}
			End if 
		End for 
		CREATE RECORD:C68([PO:39])
		myCycle:=10  //must be set each cycle
		myOK:=10
		QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=$aListOfVendors{$incPO})
		
		NxPvPOs
		ARRAY LONGINT:C221(aOrdLinesProcessed; 0)
		PO_AddNewLines
		acceptPO
		ADD TO SET:C119("Current")
	End for 
	USE SET:C118("current")
	CLEAR SET:C117("current")
	If (allowAlerts_boo)
		Case of 
			: (Records in selection:C76([PO:39])>1)
				Prs_ShowSelection(Table:C252(->[PO:39]))
			: (Records in selection:C76([PO:39])=1)
				//MODIFY RECORD([PO])
				Prs_ShowSelection(Table:C252(->[PO:39]))
			Else 
				ALERT:C41("No items added to PO")
		End case 
		myCycle:=0
		myOK:=0
	End if 
End if 