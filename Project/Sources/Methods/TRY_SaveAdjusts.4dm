//%attributes = {"publishedWeb":true}
//invSaveAdjusts
C_LONGINT:C283($i; $k)  //;$incLn;$cntLn)
C_BOOLEAN:C305($doPoSum)
C_REAL:C285($OpenAmt; $qtyOpen)
C_BOOLEAN:C305($virgin; $complete)
$virgin:=True:C214
$complete:=True:C214
//START TRANSACTION
$OpenAmt:=0
$qtyOpen:=0
$doPoSum:=False:C215
$k:=Size of array:C274(adQtyOnOrd)
CREATE SET:C116([POLine:40]; "Current")
READ WRITE:C146([POLine:40])

//   [InvStack] are created by TallyInv from dInventory records

For ($i; 1; $k)
	Case of 
		: ((adQtyOnOrd{$i}<0) & (Size of array:C274(aOpenPOs)=0))
			//If ((vInvValue="Fifo")|(vInvValue="Lifo"))
			//$booTemp:=autoStack
			//autoStack:=False
			//INVLIFOFIFOSDT(aInvParts{$i};Abs(adQtyOnOrd{$i});False)
			//autoStack:=$booTemp
			//End if 
			//CREATE RECORD([InvStack])
			//
			//[InvStack]ItemNum:=aInvParts{$i}
			//[InvStack]DateEntered:=Current date
			//[InvStack]JobKey:=aJobLists{$i}
			//[InvStack]PONum:=0
			//[InvStack]ChangeReason:=aStr20{$i}
			//[InvStack]Note:=aTexts{$i}
			//[InvStack]Approval:=Current user
			//[InvStack]DateEntered:=Current date
			//[InvStack]QtyChange:=adQtyOnOrd{$i}
			//[InvStack]SourceKey:="Manual"
			//[InvStack]UnitCost:=aItemCosts{$i}
			//[InvStack]LineNo:=0
			//[InvStack]QtyAvailable:=0//make sure
			//[InvStack]ReceiptKey:=aRecieptID{$i}
			//[InvStack]ExtendedCost:=[InvStack]UnitCost*[InvStack]QtyChange
			//SAVE RECORD([InvStack])
			Invt_dRecCreate("AJ"; CounterNew(->[InventoryStack:29]); 0; "Manual"; aJobLists{$i}; aStr20{$i}; 1; 0; aInvParts{$i}; adQtyOnOrd{$i}; 0; aItemCosts{$i}; ""; vsiteID; 0)
			//
		: (aStr20{$i}="Inship")
			$doPoSum:=True:C214
			QUERY SELECTION:C341([POLine:40]; [POLine:40]lineNum:14=aPOLines{$i})
			[POLine:40]qtyReceived:4:=[POLine:40]qtyReceived:4+adQtyOnOrd{$i}
			[POLine:40]qtyBackLogged:5:=[POLine:40]qtyBackLogged:5-adQtyOnOrd{$i}
			$discCost:=DiscountApply([POLine:40]unitCost:7; [POLine:40]discount:8; <>tcDecimalUC)
			//     [POLine]ExtendedCost:=[POLine]QtyOrdered*$discCost
			[POLine:40]backOrderAmount:13:=Round:C94([POLine:40]qtyBackLogged:5*$discCost; <>tcDecimalTt)
			Case of 
				: (([POLine:40]qtyBackLogged:5=0) & ([POLine:40]dateReceived:17=!00-00-00!))
					[POLine:40]dateReceived:17:=Current date:C33
				: (([POLine:40]qtyBackLogged:5#0) & ([POLine:40]dateReceived:17#!00-00-00!))
					[POLine:40]dateReceived:17:=!1901-01-01!
			End case 
			//      
			SAVE RECORD:C53([POLine:40])
			NEXT RECORD:C51([POLine:40])
			USE SET:C118("Current")
			//createAdjust ($i;aOpenPOs)
			//CREATE RECORD([InvStack])
			//
			//[InvStack]ItemNum:=aInvParts{$i}
			//[InvStack]DateEntered:=Current date
			//[InvStack]JobKey:=aJobLists{$i}
			//[InvStack]PONum:=aPOChanged{$i}
			//[InvStack]ChangeReason:=aStr20{$i}
			//[InvStack]Note:=aTexts{$i}
			//[InvStack]Approval:=Current user
			//[InvStack]DateEntered:=Current date
			//[InvStack]QtyChange:=adQtyOnOrd{$i}
			//[InvStack]SourceKey:=aCustCodes{vi1}
			//[InvStack]UnitCost:=aItemCosts{$i}
			//[InvStack]LineNo:=aPOLines{$i}
			//[InvStack]QtyAvailable:=[InvStack]QtyChange
			//[InvStack]ReceiptKey:=aRecieptID{$i}
			//[InvStack]ExtendedCost:=[InvStack]UnitCost*[InvStack]QtyChange
			//SAVE RECORD([InvStack])
			//$dPO:=-[InvStack]QtyChange
			
			//this should be done but what is this method for????
			//If ((adQtyOnOrd{$i}#0)&(vlReceiptID=-1))
			//vlReceiptID:=PORcpt_CreateNew ([PO]PONum;[PO]VendorID)
			//End if 
			
			Invt_dRecCreate("PO"; aPOChanged{$i}; aRecieptID{$i}; aCustCodes{vi1}; aJobLists{$i}; "PO Recv"; 1; aPOLines{$i}; aInvParts{$i}; adQtyOnOrd{$i}; -adQtyOnOrd{$i}; aItemCosts{$i}; ""; vsiteID; 0)
		Else 
			//CREATE RECORD([InvStack])
			//
			//[InvStack]ItemNum:=aInvParts{$i}
			//[InvStack]DateEntered:=Current date
			//[InvStack]JobKey:=aJobLists{$i}
			//[InvStack]PONum:=0
			//[InvStack]ChangeReason:=aStr20{$i}
			//[InvStack]Note:=aTexts{$i}
			//[InvStack]Approval:=Current user
			//[InvStack]DateEntered:=Current date
			//[InvStack]QtyChange:=adQtyOnOrd{$i}
			//[InvStack]SourceKey:="Manual"
			//[InvStack]UnitCost:=aItemCosts{$i}
			//[InvStack]LineNo:=0
			//[InvStack]QtyAvailable:=[InvStack]QtyChange
			//[InvStack]ReceiptKey:=aRecieptID{$i}
			//[InvStack]ExtendedCost:=[InvStack]UnitCost*[InvStack]QtyChange
			//SAVE RECORD([InvStack])
			Invt_dRecCreate("AJ"; CounterNew(->[InventoryStack:29]); 0; "Manual"; aJobLists{$i}; aStr20{$i}; 1; 0; aInvParts{$i}; adQtyOnOrd{$i}; 0; aItemCosts{$i}; ""; vsiteID; 0)
	End case 
End for 
TRACE:C157
If ($doPoSum)
	$OpenAmt:=0
	$virgin:=True:C214
	$complete:=True:C214
	$k:=Records in selection:C76([POLine:40])
	FIRST RECORD:C50([POLine:40])
	For ($i; 1; $k)
		$OpenAmt:=$OpenAmt+[POLine:40]backOrderAmount:13
		$virgin:=(([POLine:40]qtyReceived:4=0) & ($virgin))
		$complete:=(([POLine:40]qtyBackLogged:5=0) & ($complete))
		NEXT RECORD:C51([POLine:40])
	End for 
	[PO:39]amountBackLog:25:=$OpenAmt
	$k:=Accept_SetStat(->[PO:39]dateComplete:4; $virgin; $complete)
	SAVE RECORD:C53([PO:39])
End if 
READ ONLY:C145([POLine:40])
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([PO:39])
UNLOAD RECORD:C212([POLine:40])
UNLOAD RECORD:C212([Item:4])
//VALIDATE TRANSACTION
//
ARRAY LONGINT:C221(aPOLines; 0)  //arrays used to record adjustments
ARRAY TEXT:C222(aInvParts; 0)
ARRAY REAL:C219(adQtyOnOrd; 0)
ARRAY TEXT:C222(aTexts; 0)
ARRAY LONGINT:C221(aJobLists; 0)
ARRAY REAL:C219(aItemCosts; 0)
ARRAY TEXT:C222(aStr20; 0)
ARRAY BOOLEAN:C223(aPOLnCom; 0)  //arrays used to track completed PO lines
ARRAY LONGINT:C221(aRecieptID; 0)