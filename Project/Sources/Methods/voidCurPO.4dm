//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k)
C_BOOLEAN:C305($dummy)
IVNT_dRayInit
vlReceiptID:=-1
[PO:39]comment:27:=[PO:39]comment:27+"\r"+"\r"+"*///////////  VOID  //////////////*"+"\r"
READ WRITE:C146([POLine:40])
QUERY:C277([POLine:40]; [POLine:40]poNum:1=[PO:39]poNum:5)
FIRST RECORD:C50([POLine:40])
For ($i; 1; Records in selection:C76([POLine:40]))
	If ((<>vbDoSrlNums) & ([POLine:40]serialRc:18>0))
		Srl_DelPOLine($i)  //Srl_DelPOLine (aPOLineAction)
	End if 
	If (([POLine:40]qtyReceived:4=1) & ([POLine:40]serialRc:18>0) & (<>vbDoSrlNums))
		$dummy:=Srl_RcvrPO([POLine:40]serialRc:18)
	End if 
	[PO:39]comment:27:=[PO:39]comment:27+"\r"+[POLine:40]itemNum:2+"\t"+String:C10([POLine:40]qtyOrdered:3)+"\t"+String:C10([POLine:40]qtyReceived:4)+"\t"+String:C10([POLine:40]extendedCost:9)
	C_REAL:C285($dOnOrd)
	$dOnOrd:=[POLine:40]qtyBackLogged:5*Num:C11([POLine:40]qtyBackLogged:5>0)
	
	If (([POLine:40]qtyReceived:4#0) & (vlReceiptID=-1))
		vlReceiptID:=PORcpt_CreateNew([PO:39]poNum:5; [PO:39]vendorID:1)
	End if 
	
	Invt_dRecCreate("PO"; [PO:39]poNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]projectNum:6; "-d PO Item"; 2; [POLine:40]lineNum:14; [POLine:40]itemNum:2; -[POLine:40]qtyReceived:4; -$dOnOrd; [POLine:40]unitCost:7; ""; vsiteID; 0)
	NEXT RECORD:C51([POLine:40])
End for 
DELETE SELECTION:C66([POLine:40])
READ ONLY:C145([POLine:40])

INVT_dInvtApply

QUERY:C277([InventoryStack:29]; [InventoryStack:29]docid:5=[PO:39]poNum:5)
$k:=Records in selection:C76([InventoryStack:29])
If ($k>0)
	FIRST RECORD:C50([InventoryStack:29])
	For ($i; 1; $k)
		[InventoryStack:29]changeReason:6:="Void"
		[InventoryStack:29]createdBy:8:=Current user:C182
		[InventoryStack:29]comment:7:=[InventoryStack:29]comment:7+"\r"+"\r"+"*///////////  VOID  //////////////*"+"\r"+String:C10([InventoryStack:29]qtyAvailable:14)+" available at void."
		[InventoryStack:29]qtyAvailable:14:=0
		[InventoryStack:29]currentValue:15:=0
		SAVE RECORD:C53([InventoryStack:29])
		NEXT RECORD:C51([InventoryStack:29])
	End for 
	UNLOAD RECORD:C212([InventoryStack:29])
End if 
[PO:39]dateComplete:4:=Current date:C33
[PO:39]complete:65:=2
[PO:39]zone:28:=0
[PO:39]terms:17:="Void"
[PO:39]amount:19:=0
[PO:39]discount:20:=0
[PO:39]shipHandling:21:=0
[PO:39]taxJurisdiction:22:=0
[PO:39]miscAmount:23:=0
[PO:39]total:24:=0
[PO:39]amountBackLog:25:=0
SAVE RECORD:C53([PO:39])
