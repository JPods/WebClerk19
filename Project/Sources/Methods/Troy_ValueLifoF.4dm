//%attributes = {"publishedWeb":true}
C_LONGINT:C283($incItm; $risStk; $incStk; $risStk)
QUERY:C277([DInventory:36]; [DInventory:36]dtItemCard:16=0)
If (Records in selection:C76([DInventory:36])>0)
	ALERT:C41("Balancing InvStack cannot be performed until all Pending inventory items are cle")
Else 
	$doFifo:=False:C215
	$doLifo:=False:C215
	CONFIRM:C162("Value InvStack by FIFO?")
	If (OK=1)
		$doFifo:=True:C214
	Else 
		CONFIRM:C162("Value InvStacks by LIFO?")
		If (OK=1)
			$doLifo:=True:C214
		End if 
	End if 
	If (($doFifo) | ($doLifo))
		READ WRITE:C146([InventoryStack:29])
		FIRST RECORD:C50([Item:4])
		$risItm:=Records in selection:C76([Item:4])
		CREATE SET:C116([InventoryStack:29]; "current")
		For ($incItm; 1; $risItm)
			//SEARCH([InvStack];[InvStack]ItemNum=[Item]ItemNum;*)
			//SEARCH([InvStack];&[InvStack]QtyAvailable<0)
			//$risStk:=Records in selection([InvStack])
			//If ($risStk>0)
			//ADD TO SET([InvStack];"current")
			//FIRST RECORD([InvStack])
			////For ($incStk;1;$risStk)
			////$negCnt:=$negCnt+[InvStack]QtyAvailable
			////[InvStack]QtyAvailable:=0
			////SAVE RECORD([InvStack])
			////NEXT RECORD([InvStack])
			////End for 
			//Else 
			//$negCnt:=0
			//End if 
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]itemNum:2=[Item:4]itemNum:1; *)
			QUERY:C277([InventoryStack:29];  & [InventoryStack:29]qtyAvailable:14>0)
			ADD TO SET:C119([InventoryStack:29]; "current")
			If ($doFifo)
				ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]dateEntered:3; <)  //[InvStack]DTSync;<)
			Else   // (vInvValue="Lifo")  
				ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]dateEntered:3; >)  //[InvStack]DTSync;>)
			End if 
			FIRST RECORD:C50([InventoryStack:29])
			$Qty2Bal:=[Item:4]qtyOnHand:14  //add the 
			$risStk:=Records in selection:C76([InventoryStack:29])
			For ($incStk; 1; $risStk)
				Case of 
					: ($Qty2Bal<=0)
						[InventoryStack:29]qtyAvailable:14:=0
					: ($Qty2Bal>[InventoryStack:29]qtyAvailable:14)
						$Qty2Bal:=$Qty2Bal-[InventoryStack:29]qtyAvailable:14
					: ($Qty2Bal<=[InventoryStack:29]qtyAvailable:14)
						[InventoryStack:29]qtyAvailable:14:=$Qty2Bal
						$Qty2Bal:=0
				End case 
				SAVE RECORD:C53([InventoryStack:29])
				NEXT RECORD:C51([InventoryStack:29])
			End for 
			If ($Qty2Bal>0)
				CREATE RECORD:C68([InventoryStack:29])
				
				[InventoryStack:29]itemNum:2:=[Item:4]itemNum:1
				[InventoryStack:29]qtyOnHand:9:=$Qty2Bal
				[InventoryStack:29]qtyAvailable:14:=$Qty2Bal
				[InventoryStack:29]changeReason:6:="Forced Correction"
				[InventoryStack:29]vendorID:10:="Internal"
				[InventoryStack:29]unitCost:11:=[Item:4]costAverage:13
				[InventoryStack:29]comment:7:=""
				[InventoryStack:29]createdBy:8:=Current user:C182
				[InventoryStack:29]dateEntered:3:=Current date:C33
				[InventoryStack:29]extendedCost:17:=[InventoryStack:29]unitCost:11*[InventoryStack:29]qtyOnHand:9
				[InventoryStack:29]tableNum:30:=-7
				SAVE RECORD:C53([InventoryStack:29])
			End if 
			NEXT RECORD:C51([Item:4])
		End for 
		UNLOAD RECORD:C212([Item:4])
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		READ ONLY:C145([InventoryStack:29])
		ProcessTableOpen(->[InventoryStack:29])
	End if 
End if 