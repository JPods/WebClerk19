// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/23/13, 11:41:35
// ----------------------------------------------------
// Method: Object Method: [Control].Packing.b4
// Description Carton Button
// 
//
// Parameters
// ----------------------------------------------------
//### jwm ### 20130423_1143 added vResponse to Log Carton Quantity Added

KeyModifierCurrent
//TRACE
vResponse:=""
If (Size of array:C274(aoLnSelect)>0)
	$itemNum:=aOItemNum{aoLnSelect{1}}
	//$itemNum:=aLiItemNum{aLiLoadItemSelect{1}}
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
	If (Records in selection:C76([Item:4])=1)
		$qtyBulk:=[Item:4]qtyBundleSell:79  //skip rgw
		If ($qtyBulk<1)
			<>pkScaleComment:="No Bulk Quantity Defined"
			PKAlertWindow
		Else 
			If (aOQtyBL{aoLnSelect{1}}<($qtyBulk-1))
				<>pkScaleComment:="Bulk Qty Exceeds Backlog"
				PKAlertWindow
			Else 
				vResponse:="Carton Quantity Added"
				If (OptKey=0)
					PKLineIntoBox(3; $qtyBulk-1)
				Else 
					PKLineIntoBox(3; $qtyBulk)
				End if 
				<>pkScaleComment:="Carton Quantity Added"
				PKAlertWindow
			End if 
		End if 
	End if 
End if 
UNLOAD RECORD:C212([Item:4])