//%attributes = {"publishedWeb":true}
//Qx_AcctQtyItem
//TRACE
C_TEXT:C284($mytext1; $mytext2; $mytext3; $mytext4; $mytext5; $mytext6)
C_LONGINT:C283($p)
$p:=Position:C15("<&"; [WorkOrder:66]description:3)
If ($p>0)
	$mytext4:=Tx_ClipWithIn([WorkOrder:66]description:3; "jitAcct"; "<&tb"; "<&te>")
	If ($mytext4#[WorkOrder:66]description:3)
		[WorkOrder:66]description:3:=Tx_ClipArround([WorkOrder:66]description:3; "jitAcct"; "<&tb"; "<&te>")
		srAcct:=Tx_ClipBetween($mytext4; "<&te>"; ">")
		SrCustomerRec(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct; bChangeRec; False:C215)
		[WorkOrder:66]company:36:=srCustomer
		[WorkOrder:66]customerid:28:=[Customer:2]customerID:1
		[WorkOrder:66]action:33:="New"  //"ReadyToBuild"
	End if 
	pPartNum:=""
	$mytext4:=Tx_ClipWithIn([WorkOrder:66]description:3; "jitItem"; "<&tb"; "<&te>")
	If ($mytext4#[WorkOrder:66]description:3)
		[WorkOrder:66]description:3:=Tx_ClipArround([WorkOrder:66]description:3; "jitItem"; "<&tb"; "<&te>")
		pPartNum:=Tx_ClipBetween($mytext4; "<&te>"; ">")
	End if 
	$mytext4:=Tx_ClipWithIn([WorkOrder:66]description:3; "jitQty"; "<&tb"; "<&te>")
	If ($mytext4#[WorkOrder:66]description:3)
		[WorkOrder:66]description:3:=Tx_ClipArround([WorkOrder:66]description:3; "jitQty"; "<&tb"; "<&te>")
		$mytext4:=Tx_ClipBetween($mytext4; "<&te>"; ">")
		C_REAL:C285($myQty)
		$myQty:=Num:C11($myText4)
	Else 
		$myQty:=[WorkOrder:66]qtyOrdered:13
	End if 
	$mytext4:=Tx_ClipWithIn([WorkOrder:66]description:3; "jitPO"; "<&tb"; "<&te>")
	If ($mytext4#[WorkOrder:66]description:3)
		[WorkOrder:66]description:3:=Tx_ClipArround([WorkOrder:66]description:3; "jitPO"; "<&tb"; "<&te>")
		$mytext4:=Tx_ClipBetween($mytext4; "<&te>"; ">")
		[WorkOrder:66]processCodes:24:=$myText4
	End if 
	[WorkOrder:66]description:3:=Qx_SetGroups([WorkOrder:66]description:3)
	//
	//////Strips all the page details - delete if flexibility is required
	C_LONGINT:C283($pT; $pP)
	//TRACE
	$pT:=Position:C15("<&t"; [WorkOrder:66]description:3)
	$pP:=Position:C15("<&p"; [WorkOrder:66]description:3)
	If ((($pT<$pP) & ($pP>0) & ($pT>0)) | (($pT>0) & ($pP=0)))
		[WorkOrder:66]description:3:=Substring:C12([WorkOrder:66]description:3; $pT)
	Else 
		[WorkOrder:66]description:3:=Substring:C12([WorkOrder:66]description:3; $pP)
	End if 
	//////Strips all the page details - delete if flexibility is required  
	//  
	WOLnFillItem(pPartNum; -5)
	If ([WorkOrder:66]itemNum:12="han@")
		[WorkOrder:66]profile3:39:="<3"
	End if 
	[WorkOrder:66]qtyOrdered:13:=$myQty
	
	Qx_WONumInsert  //inserts the wo number into the comment
	
	HIGHLIGHT TEXT:C210([WorkOrder:66]description:3; 1; 1)
	
End if 